#include "restlistmodel.h"

RestListModel::RestListModel(QObject * parent)
    :QAbstractListModel(parent)
{

    QJsonObject item;
    item.insert("nom", "schutz");
    item.insert("age", 54);

    QJsonObject item2;
    item.insert("nom", "perrine");
    item.insert("age", 23);

    QJsonObject item3;
    item.insert("nom", "boby");
    item.insert("age", 34);



    mDatas.append(item);
    mDatas.append(item2);
    mDatas.append(item3);


}

RestListModel::~RestListModel()
{

}

QVariant RestListModel::data(const QModelIndex &index, int role) const
{

    if (!index.isValid())
        return QVariant();

    if ( role == Qt::DisplayRole){

        return mDatas.at(index.row());


    }

    return QVariant();


}

int RestListModel::rowCount(const QModelIndex &parent) const
{

    return mDatas.count();


}

