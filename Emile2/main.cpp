#include <QIcon>
#include <QQuickStyle>
#include <QApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QQuickStyle::setStyle(QStringLiteral("Material"));
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication::setApplicationName(QStringLiteral("Emile2"));
    QApplication::setOrganizationName(QStringLiteral("Emile2"));
    QApplication::setOrganizationDomain(QStringLiteral("org.qtproject.emile2"));
    QApplication app(argc, argv);
    app.setWindowIcon(QIcon::fromTheme(":/assets/app_icon.png"));

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
