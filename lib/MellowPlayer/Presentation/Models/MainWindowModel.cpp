#include <QtWebEngine>
#include <QMessageBox>
#include <QQuickStyle>
#include <MellowPlayer/Application/Utils/AlbumArt/ILocalAlbumArt.hpp>
#include <MellowPlayer/Application/Logging/LoggingManager.hpp>
#include <MellowPlayer/Application/Player/Player.hpp>
#include <MellowPlayer/Application/Settings/Settings.hpp>
#include <MellowPlayer/Application/Settings/Setting.hpp>
#include <MellowPlayer/Presentation/Models/QtApplicationModel.hpp>
#include <MellowPlayer/Presentation/Models/ListeningHistory/ListeningHistoryModel.hpp>
#include <MellowPlayer/Presentation/Models/StreamingServices/StreamingServicesModel.hpp>
#include <MellowPlayer/Presentation/Models/StreamingServices/StreamingServiceStyleModel.hpp>
#include <MellowPlayer/Presentation/Models/Settings/Types/SettingModel.hpp>
#include "MainWindowModel.hpp"

USE_MELLOWPLAYER_NAMESPACE(Application)
USE_MELLOWPLAYER_NAMESPACE(Presentation)

MainWindowModel::MainWindowModel(StreamingServicesModel& streamingServicesModel,
                                 ListeningHistoryModel& listeningHistoryModel,
                                 StreamingServiceStyleModel& pluginStyleModel,
                                 IQtApplication& qtApp,
                                 IPlayer& player,
                                 ILocalAlbumArt& albumArt,
                                 Settings& settings) :
        logger(LoggingManager::instance().getLogger("MainWindowModel")),
        settings(settings), streamingServices(streamingServicesModel),
        listeningHistory(listeningHistoryModel), settingsModel(settings) {
    qmlRegisterUncreatableType<Player>("MellowPlayer", 3, 0, "Player", "Player cannot be instantiated from QML");
    qmlRegisterUncreatableType<SettingKey>("MellowPlayer", 3, 0, "SettingKey",
                                           "SettingKey caanot be instantiated from QML");
    auto context = qmlApplicationEngine.rootContext();
    context->setContextProperty("streamingServices", &streamingServicesModel);
    context->setContextProperty("listeningHistory", &listeningHistoryModel);
    context->setContextProperty("style", &pluginStyleModel);
    context->setContextProperty("player", &player);
    context->setContextProperty("albumArt", &albumArt);
    context->setContextProperty("clipboard", &clipBoardModel);
    context->setContextProperty("settings", &settingsModel);
    context->setContextProperty("windowModel", this);
    context->setContextProperty("qtApp", &qtApp);
}

bool MainWindowModel::load() {
    LOG_TRACE(logger, "loading");
    QQuickStyle::setStyle("Material");
    QtWebEngine::initialize();
    streamingServices.initialize();
    listeningHistory.initialize();
    qmlApplicationEngine.addImportPath("qrc:/MellowPlayer/Presentation/Views");
    qmlApplicationEngine.load(QUrl("qrc:/MellowPlayer/Presentation/Views/main.qml"));
    LOG_TRACE(logger, "loaded");
    return true;
}

void MainWindowModel::show() {
    setVisible(true);
}

void MainWindowModel::hide() {
    setVisible(false);
}

void MainWindowModel::setVisible(bool value) {
    if (value != visible) {
        visible = value;
        emit visibleChanged();
    }
}

bool MainWindowModel::isVisible() const {
    return visible;
}