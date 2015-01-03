#ifndef FILTERMODEL_H
#define FILTERMODEL_H

#include <QObject>
#include <QSortFilterProxyModel>
#include "restmodel.h"

class FilterRestModel : public QSortFilterProxyModel
{
    Q_OBJECT
    Q_PROPERTY(RestModel* restModel WRITE setRestModel)
    Q_PROPERTY(QString filterKey WRITE setFilterKey READ filterKey)

public:
    FilterRestModel(QObject * parent = 0);
    ~FilterRestModel();
    void setRestModel(RestModel * model);

    Q_INVOKABLE void setFilterKey(const QString& key);
    QString filterKey() const;

private:
    RestModel * mModel;
    QString mFilterKey;


};

#endif // FILTERRESTMODEL_H
