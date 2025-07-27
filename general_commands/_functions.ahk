#Requires AutoHotkey v2.0

; checks if there is a missing config, and adds them to the config file
checkMissingConfigs(templateConfig, currentConfig) {
    rewriteConfigFile := false

    for key, value in templateConfig {
        if currentConfig.Has(key) {
            if IsObject(value) {
                rewriteConfigFile := true
                checkMissingConfigsSubArray := checkMissingConfigs(value, currentConfig[key])

                currentConfig[key] := checkMissingConfigsSubArray['currentConfig']
            }

            continue
        }

        currentConfig[key] := value
        rewriteConfigFile := true
    }

    return Map(
        "rewriteConfigFile", rewriteConfigFile,
        "currentConfig", currentConfig,
    )
}