#ifndef RESTLISTVIEW_H
#define RESTLISTVIEW_H

#include <QObject>
#include <QAbstractListModel>
#include <QHash>
#include <QByteArray>
#include <QJsonArray>
#include "request.h"

class RestListModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)

public:
    RestListModel(QObject * parent = 0);
    ~RestListModel();

    QVariant data(const QModelIndex &index, int role) const;
    int rowCount(const QModelIndex &parent) const;
    QHash<int, QByteArray> roleNames() const;
    void setSource(const QString& source);
    const QString &source();

public slots:
    void get(const QJsonObject& params = QJsonObject());
    void nextPage();
    void previousPage();
    void setPage(int page = 0);
    void reload();


protected slots:
    void loadData(QJsonObject data);

signals:
    void sourceChanged();

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
