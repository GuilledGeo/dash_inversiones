
# 🔐 Configuración SSH para GitHub y GitLab Privado (Ixorigué)

Este documento resume cómo configurar correctamente el acceso a GitHub y al GitLab privado de Ixorigué utilizando autenticación SSH desde Windows + PowerShell.

---

## 🧰 Requisitos previos

- Tener Git y OpenSSH instalados
- Tener un par de claves SSH generadas
- Tener las claves públicas cargadas en GitHub y GitLab

---

## 📁 Estructura esperada en `~/.ssh`

Tu carpeta `C:\Users\usuario\.ssh\` debería tener al menos:

- `id_ed25519` → clave privada usada para **GitHub y GitLab privado**
- `id_ed25519.pub` → clave pública que se sube a **GitHub** y **GitLab**
- `config` → archivo de configuración de hosts SSH

---

## 📌 Paso 1. Subir clave pública a GitHub

1. Copia el contenido de tu clave pública:

   ```powershell
   cat $env:USERPROFILE\.ssh\id_ed25519.pub
   ```

2. Ve a [GitHub → Settings → SSH and GPG Keys](https://github.com/settings/keys)
3. Añade una nueva clave SSH (Name: `Torre Guille` o similar)

---

## 📌 Paso 2. Subir clave pública a GitLab privado (Ixorigué)

1. Entra a [https://git.ixorigue.com/-/profile/keys](https://git.ixorigue.com/-/profile/keys)
2. Pega la misma clave pública (`id_ed25519.pub`)

---

## 📝 Paso 3. Crear archivo `~/.ssh/config`

Abre PowerShell y edita el archivo:

```powershell
notepad $env:USERPROFILE\.ssh\config
```

Pega este contenido:

```ssh
# GitHub
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519
  IdentitiesOnly yes

# GitLab privado Ixorigue
Host git.ixorigue.com
  HostName git.ixorigue.com
  User git
  IdentityFile ~/.ssh/id_ed25519
  IdentitiesOnly yes
```

---

## 🔐 Paso 4. Cargar la clave en el agente SSH

```powershell
ssh-add $env:USERPROFILE\.ssh\id_ed25519
```

Confirma que está cargada:

```powershell
ssh-add -l
```

---

## 🔄 Paso 5. Cambiar los remotos del repositorio

Dentro de tu proyecto, configura las URLs de los remotos:

```powershell
# GitHub
git remote set-url github git@github.com:GuilledGeo/ixo-analitica-soporte.git

# GitLab privado
git remote set-url gitlab git@git.ixorigue.com:ixorigue/analytics/ixo-analitica-soporte.git
```

Verifica:

```powershell
git remote -v
```

Debe mostrar:

```
github  git@github.com:GuilledGeo/ixo-analitica-soporte.git (fetch)
github  git@github.com:GuilledGeo/ixo-analitica-soporte.git (push)
gitlab  git@git.ixorigue.com:ixorigue/analytics/ixo-analitica-soporte.git (fetch)
gitlab  git@git.ixorigue.com:ixorigue/analytics/ixo-analitica-soporte.git (push)
```

---

## ✅ Paso 6. Verificar autenticación

```powershell
ssh -T git@github.com
# → Hi GuilledGeo! You've successfully authenticated...

ssh -T git@git.ixorigue.com
# → Welcome to GitLab, @guillermo54!
```

---

## 🚀 Uso habitual

Pushear a GitHub:

```powershell
git push github main
```

Pushear a GitLab privado:

```powershell
git push gitlab main
```

Hacer `pull` desde cualquiera:

```powershell
git pull github main
# o
git pull gitlab main
```

---

## 🧹 Extra: limpiar claves del agente

```powershell
ssh-add -D
```

---

> Configurado correctamente, puedes trabajar sin introducir usuario/contraseña cada vez, de forma segura y con múltiples remotos.
