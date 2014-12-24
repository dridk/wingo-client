#ifndef RESTLISTVIEW_H
#define RESTLISTVIEW_H

#include <QObject>
#include <QAbstractListModel>
#include <QJsonArray>
#include "request.h"

class RestListModel : public QAbstractListModel
{
public:
    RestListModel(QObject * parent = 0);
    ~RestListModel();

    QVariant data(const QModelIndex &index, int role) const;
    int rowCount(const QModelIndex &parent=QModelIndex()) const;



private:
    QJsonArray mDatas;
    Request mRequest;


};

#endif // RESTLISTVIEW_H
