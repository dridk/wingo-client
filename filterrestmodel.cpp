#include "filterrestmodel.h"
#include <QDebug>

FilterRestModel::FilterRestModel(QObject * parent ):
    QSortFilterProxyModel(parent)
{
    qDebug()<<"test";
    mModel = 0;
}

FilterRestModel::~FilterRestModel()
{

}

void FilterRestModel::setRestModel(RestModel *model)
{
    mModel = model;
    setSourceModel(mModel);
}

void FilterRestModel::setFilterKey(const QString &key)
{

    if (!mModel)
        return;

    qDebug()<<"roles names"<<mModel->roleNames();

    Qt::ItemDataRole role;
    foreach (int i,  mModel->roleNames().keys()) {

        if (mModel->roleNames().value(i) == key) {
            role = Qt::ItemDataRole(i);
            mFilterKey = key;
            setFilterRole(role);
            return;

        }

    }





}

QString FilterRestModel::filterKey() const
{
    return  mFilterKey;
}

