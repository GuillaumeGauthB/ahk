#Requires AutoHotkey v2.0

templateConfigMap := Map(
    "ipAddress", "",
    "savedPassword", "UsCD*R:Nu5pW~S!"
)

; TODO:
; 1. Si le fichier n'existe pas, le creer avec le contenu de l'array template
; 2. Si le fichier existe mais n'a pas toutes les cles, les ajouter et mettre a jour le fichier
; 3. Mettre le contenu du fichier dans configMap

; JSON: https://autohotkey.wiki/guides:json
; Creation fichier: https://www.autohotkey.com/docs/v2/lib/FileAppend.htm
if not FileExist("../json/general_commands.ahk") {
    ; myObject := Map("a", 1, "b", 2, "c", [3, 4, 5]) ; v2
    ; FileAppend()
    ; JSON.dump()


} else {

    configMap := templateConfigMap
}