#ifndef RESTLISTVIEW_H
#define RESTLISTVIEW_H

#include <QObject>
#include <QAbstractListModel>
#include <QHash>
#include <QByteArray>
#include <QJsonArray>
#include "request.h"

class RestModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(bool isLoading READ isLoading NOTIFY isLoadingChanged)


public:
    RestModel(QObject * parent = 0);
    ~RestModel();

    QVariant data(const QModelIndex &index, int role) const;
    int rowCount(const QModelIndex &parent) const;
    QHash<int, QByteArray> roleNames() const;
    void setSource(const QString& source);
    const QString &source();
    bool isLoading();

    Q_INVOKABLE QJsonValue get(int index) const;
    Q_INVOKABLE bool remove(int index) ;



public slots:
    void setParams(const QJsonObject& params = QJsonObject());
    void nextPage();
    void previousPage();
    void setPage(int page = 0);
    void reload();


protected slots:
    void loadData(QJsonObject data);

signals:
    void sourceChanged();
    void isLoadingChanged();
    void error(int code, QString message);
    void success();

protected:
    void createRoleNames();


private:
    QJsonArray mDatas;
    QHash<int, QByteArray> mRoleNames;
    QJsonObject mParams;
    Request * mRequest;
    int mCurrentPage;



};

#endif // RESTLISTVIEW_H
