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
public:
    RestListModel(QObject * parent = 0);
    ~RestListModel();

    QVariant data(const QModelIndex &index, int role) const;
    int rowCount(const QModelIndex &parent) const;
    QHash<int, QByteArray> roleNames() const;


private:
    QJsonArray mDatas;
    QHash<int, QByteArray> mRoleNames;


};

#endif // RESTLISTVIEW_H
