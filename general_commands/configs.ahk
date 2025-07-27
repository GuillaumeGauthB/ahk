#Requires AutoHotkey v2.0
#include ../packages/JXON_ahk2/_JXON.ahk

templateConfigMap := Map(
    "ipAddress", "",
    "savedPassword", "template_password",
    "oldSavedPassword", "template_old_password"
)

; if config file does not exist, create it
if not FileExist("../json/configs.json") {
    templateConfigMapJSON := jxon_dump(templateConfigMap, 1)
    FileAppend templateConfigMapJSON, "../json/configs.json"

    configMap := templateConfigMap
} else {
    configFileContent := FileRead("../json/configs.json")
    configFileMap := jxon_load(&configFileContent)
    rewriteConfigFile := false

    ; if there is a key in the template configs that is not in the current file,
    ; add it
    for key, value in templateConfigMap {
        if configFileMap.Has(key)
            continue

        configFileMap[key] := value
        rewriteConfigFile := true
    }

    if rewriteConfigFile {
        FileDelete "../json/configs.json"

        configMapJSON := jxon_dump(configFileMap, 1)
        FileAppend configMapJSON, "../json/configs.json"    
    }

    configMap := configFileMap
}