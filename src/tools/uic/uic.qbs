import qbs
import qbs.ModUtils

QtHostTool {
    toolFileTag: "qt.uic-tool"
    condition: QtGlobalPrivateConfig.gui && QtGlobalPrivateConfig.widgets
    qbsSearchPaths: [project.qtbaseShadowDir + "/src/corelib/qbs"]

    Depends { name: "QtGlobalPrivateConfig" }
    Depends { name: "QtCoreConfig" }
    useBootstrapLib: base || !QtCoreConfig.commandlineparser || !QtCoreConfig.textcodec
        || !QtCoreConfig.xmlstreamreader || !QtCoreConfig.xmlstreamwriter
    Depends { name: "Qt.bootstrap-private"; condition: useBootstrapLib }
    Depends { name: "Qt.core-private"; condition: !useBootstrapLib }

    cpp.defines: base.concat(["QT_UIC",
                              "QT_UIC_CPP_GENERATOR",
                              "QT_NO_CAST_FROM_ASCII",
                              "QT_NO_FOREACH"])
    cpp.includePaths: base.concat(".", "cpp")

    Export {
        Rule {
            inputs: "uic"
            explicitlyDependsOn: ["qt.uic-tool"]
            Artifact {
                fileTags: "hpp"
                filePath: FileInfo.joinPaths(input.Qt.core.generatedHeadersDir,
                                             'ui_' + input.completeBaseName + '.h')
            }
            prepare: {
                var uic = explicitlyDependsOn["qt.uic-tool"][0];
                var uicFilePath = uic.qbs.install ? ModUtils.artifactInstalledFilePath(uic)
                                                  : uic.filePath;
                var cmd = new Command(uicFilePath, ["-o", output.filePath, input.filePath]);
                cmd.description = "uic " + input.fileName;
                cmd.highlight = "codegen";
                return cmd;
            }
        }
    }

    files: [
        "customwidgetsinfo.cpp",
        "customwidgetsinfo.h",
        "databaseinfo.cpp",
        "databaseinfo.h",
        "driver.cpp",
        "driver.h",
        "globaldefs.h",
        "main.cpp",
        "option.h",
        "treewalker.cpp",
        "treewalker.h",
        "ui4.cpp",
        "ui4.h",
        "uic.cpp",
        "uic.h",
        "utils.h",
        "validator.cpp",
        "validator.h",
    ]

    Group {
        condition: true
        name: "cpp generator"
        prefix: "cpp/"
        files: [
            "cppextractimages.cpp",
            "cppextractimages.h",
            "cppwritedeclaration.cpp",
            "cppwritedeclaration.h",
            "cppwriteicondata.cpp",
            "cppwriteicondata.h",
            "cppwriteicondeclaration.cpp",
            "cppwriteicondeclaration.h",
            "cppwriteiconinitialization.cpp",
            "cppwriteiconinitialization.h",
            "cppwriteincludes.cpp",
            "cppwriteincludes.h",
            "cppwriteinitialization.cpp",
            "cppwriteinitialization.h",
        ]
    }
}