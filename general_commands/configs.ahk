#Requires AutoHotkey v2.0
#include ../packages/JXON_ahk2/_JXON.ahk
#include ./_functions.ahk

templateConfigMap := Map(
    "ipAddress", "",
    "savedPassword", "template_password",
    "oldSavedPassword", "template_old_password",
    "activeModules", Map(
        "work", true,
        "random", true,
    )
)

configDir := "../json/"
configFileName := configDir . "general_commands_configs.json"

; if folder does not exist, create it
if not DirExist(configDir)
    DirCreate(configDir)

; if config file does not exist, create it
if not FileExist(configFileName) {
    templateConfigMapJSON := jxon_dump(templateConfigMap, 1)
    FileAppend templateConfigMapJSON, configFileName

    configMap := templateConfigMap
} else {
    configFileContent := FileRead(configFileName)
    configFileMap := jxon_load(&configFileContent)

    checkMissingConfigsResult := checkMissingConfigs(templateConfigMap, configFileMap)
    configFileMap := checkMissingConfigsResult['currentConfig']

    if checkMissingConfigsResult['rewriteConfigFile'] {
        FileDelete configFileName

        configMapJSON := jxon_dump(configFileMap, 1)
        FileAppend configMapJSON, configFileName   
    }

    configMap := configFileMap
}