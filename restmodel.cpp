#include "restmodel.h"

RestModel::RestModel(QObject * parent)
    :QAbstractListModel(parent)
{

    mRequest = new Request;

    connect(mRequest,SIGNAL(success(QJsonObject)),this,SLOT(loadData(QJsonObject)));
    connect(mRequest,SIGNAL(sourceChanged()),this,SIGNAL(sourceChanged()));
    connect(mRequest,SIGNAL(isLoadingChanged()),this,SIGNAL(isLoadingChanged()));
    connect(mRequest,SIGNAL(error(int,QString)),this,SIGNAL(error(int,QString)));
}


RestModel::~RestModel()
{
    delete mRequest;
}

QVariant RestModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    foreach (int keyId , mRoleNames.keys()) {

        if (role == keyId) {
            QString key = mRoleNames.value(keyId);
            //key is $keyname.. remove first character '$'
            key = key.right(key.length()-1);
            QJsonObject obj = mDatas.at(index.row()).toObject();
            if (obj.keys().contains(key))
                return obj.value(key);
            else
                return QJsonValue::Undefined;
        }
    }
    return QJsonValue::Undefined;
}

int RestModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return mDatas.count();
}

QHash<int, QByteArray> RestModel::roleNames() const
{
    return mRoleNames;
}

void RestModel::setSource(const QString &source)
{
    mRequest->setSource(source);

}
const QString &RestModel::source()
{
    return mRequest->source();
}
bool RestModel::isLoading()
{
    return mRequest->isLoading();
}

QJsonValue RestModel::get(int index) const
{
    return mDatas.at(index);
}

bool RestModel::remove(int index)
{
    if (index >= mDatas.count()){
        qDebug()<<"remove index out or range";
        return false;
    }

    beginRemoveRows(QModelIndex(),index,index);
    mDatas.removeAt(index);
    endRemoveRows();
    return true;
}
void RestModel::setParams(const QJsonObject &params)
{
    mParams = params;
}
void RestModel::loadData(QJsonObject data)
{
    if (data.length() > 0) {

        beginResetModel();
        mDatas = data.value("results").toArray();
        createRoleNames();
        endResetModel();
    }

    emit success();

}

void RestModel::nextPage()
{
    //Not yet implemented
    reload();
}

void RestModel::previousPage()
{
    //Not yet implemented
    reload();
}

void RestModel::setPage(int page)
{
    //Not yet implemented
    reload();

}

void RestModel::reload()
{
    mRequest->get(mParams);
}

void RestModel::createRoleNames()
{
    mRoleNames.clear();

    if (mDatas.isEmpty())
        return;

    //Load all keys.. by looping arround all items
    QSet<QString> mKeys;
    foreach (QJsonValue val, mDatas) {

        QJsonObject obj = val.toObject();
        foreach (QString key, obj.keys()){

            mKeys.insert(key);
        }
    }


    //Create roles names !
    int keyId = Qt::UserRole+1;
    foreach (QString key , mKeys)
    {
        QString roleName = "$"+key;
        mRoleNames.insert(keyId, roleName.toUtf8());
        keyId++;
    }

}




