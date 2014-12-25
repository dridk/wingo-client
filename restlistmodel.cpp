#include "restlistmodel.h"

RestListModel::RestListModel(QObject * parent)
    :QAbstractListModel(parent)
{

    QJsonObject item;
    item.insert("nom", "schutz");
    item.insert("age", 54);

    QJsonObject item2;
    item2.insert("nom", "perrine");
    item2.insert("age", 23);

    QJsonObject item3;
    item3.insert("nom", "boby");
    item3.insert("age", 34);


    mDatas.append(item);
    mDatas.append(item2);
    mDatas.append(item3);


    QJsonObject ref = mDatas.first().toObject();
    int keyId = Qt::UserRole+1;
    foreach (QString key , ref.keys())
    {

        QString roleName = "$"+key;
        mRoleNames.insert(keyId, roleName.toUtf8());
        keyId++;


    }




}

RestListModel::~RestListModel()
{

}

QVariant RestListModel::data(const QModelIndex &index, int role) const
{

    if (!index.isValid())
        return QVariant();




    foreach (int keyId , mRoleNames.keys()) {


        if (role == keyId) {
            QString key = mRoleNames.value(keyId);
            key = key.right(key.length()-1);
            return mDatas.at(index.row()).toObject().value(key);
        }



    }



    return QVariant();


}

int RestListModel::rowCount(const QModelIndex &parent) const
{

    return mDatas.count();


}

QHash<int, QByteArray> RestListModel::roleNames() const
{
    return mRoleNames;
}




