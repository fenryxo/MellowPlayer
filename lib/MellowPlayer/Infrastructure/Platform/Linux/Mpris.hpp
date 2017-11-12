#pragma once

#include <MellowPlayer/Infrastructure/Platform/Linux/IMpris.hpp>
#include <memory>

#ifdef Q_OS_LINUX

namespace MellowPlayer::Domain
{
    class IPlayer;
    class ILocalAlbumArt;
    class IMainWindow;
    class IDeprecatedQtApplication;
    class ILogger;
}

namespace MellowPlayer::Infrastructure
{
    class Mpris2Root;
    class Mpris2Player;

    class Mpris : public IMpris
    {
    public:
        Mpris(Domain::IPlayer& player, Domain::ILocalAlbumArt& localAlbumArt, Domain::IMainWindow& window,
                        Domain::IDeprecatedQtApplication& application);
        ~Mpris();

        bool start() override;

    private:
        static QString SERVICE_NAME;
        static QString OBJECT_NAME;

        Domain::ILogger& logger_;
        std::unique_ptr<QObject> parent_;
        QObject* mpris2Root_;
        QObject* mpris2Player_;
        QString serviceName_;
    };
}

#endif
