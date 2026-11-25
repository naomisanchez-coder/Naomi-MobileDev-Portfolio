"""Prepara una copia aislada del proyecto histórico con los estilos actuales.

Ejecutar desde cualquier carpeta con Python 3. No cambia ramas ni escribe en Git.
El plist real se copia únicamente al destino temporal; nunca se publica.
"""
from io import BytesIO
from pathlib import Path
import shutil
import subprocess
import tarfile
import tempfile

BASE = "a81fb8fcecb92e840a4d2b4ed25e92c3711ad385"
repo = Path(__file__).resolve().parents[3]
current = repo / "Semana14/Lab14IntroFirebase/Lab14IntroFirebase"
plist = current / "GoogleService-Info.plist"
if not plist.is_file():
    raise SystemExit("Configura primero el plist local del Lab14, como indica README.md.")
auth = (current / "AuthView.swift").read_text()
if auth.count("MessagesView()") != 1:
    raise SystemExit("Revisa la rama autenticada de AuthView antes de preparar la copia.")
archive = subprocess.check_output(
    ["git", "archive", BASE, "--", "Semana14/Lab14IntroFirebase"], cwd=repo
)
destination = Path(tempfile.mkdtemp(prefix="lab14-bienvenida-"))
with tarfile.open(fileobj=BytesIO(archive)) as tar:
    for member in tar.getmembers():
        parts = Path(member.name).parts
        if not parts or parts[0] != "Semana14" or ".." in parts or member.issym() or member.islnk():
            raise ValueError("Ruta no permitida en la copia histórica")
        target = destination / member.name
        if member.isdir():
            target.mkdir(parents=True, exist_ok=True)
        elif member.isfile():
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(tar.extractfile(member).read())
app = destination / "Semana14/Lab14IntroFirebase/Lab14IntroFirebase"
(app / "AuthView.swift").write_text(auth.replace(
    "MessagesView()",
    "AuthenticationWelcomeView(email: Auth.auth().currentUser?.email ?? email, signOut: signOut)",
))
shutil.copy2(current / "LabTheme.swift", app / "LabTheme.swift")
shutil.copy2(Path(__file__).with_name("AuthenticationWelcomeView.swift"), app / "AuthenticationWelcomeView.swift")
shutil.copy2(plist, app / "GoogleService-Info.plist")
(app / "GoogleService-Info.plist").chmod(0o600)
(destination / "Semana14/origen-bienvenida.txt").write_text(
    f"Base histórica: {BASE}\nCopia con presentación rediseñada y Firebase real.\n"
)
print(destination / "Semana14/Lab14IntroFirebase/Lab14IntroFirebase.xcodeproj")
