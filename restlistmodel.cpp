#include "restlistmodel.h"

RestListModel::RestListModel(QObject * parent)
    :QAbstractListModel(parent)
{


    mRequest = new Request;

    connect(mRequest,SIGNAL(success(QJsonObject)),this,SLOT(loadData(QJsonObject)));
    connect(mRequest,SIGNAL(sourceChanged()),this,SIGNAL(sourceChanged()));




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

void RestListModel::get(const QJsonValue &data)
{

    mRequest->get(data);


}

void RestListModel::setSource(const QString &source)
{
    mRequest->setSource(source);

}

const QString &RestListModel::source()
{
    return mRequest->source();
}

void RestListModel::loadData(QJsonObject data)
{

    if (data.length() > 0) {

        beginResetModel();
        mDatas = data.value("results").toArray();
        createRoleNames();
        endResetModel();

    }

}

void RestListModel::createRoleNames()
{
    mRoleNames.clear();

    if (mDatas.isEmpty())
        return;

    QJsonObject ref = mDatas.first().toObject();
    int keyId = Qt::UserRole+1;
    foreach (QString key , ref.keys())
    {
        QString roleName = "$"+key;
        mRoleNames.insert(keyId, roleName.toUtf8());
        keyId++;

    }

}




