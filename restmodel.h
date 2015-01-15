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
    Q_PROPERTY(QString maxId READ maxId WRITE setMaxId NOTIFY maxIdChanged)
    Q_PROPERTY(int count READ count NOTIFY success)
    Q_PROPERTY(int totalCount READ totalCount NOTIFY success)



public:
    RestModel(QObject * parent = 0);
    ~RestModel();

    QVariant data(const QModelIndex &index, int role) const;
    int rowCount(const QModelIndex &parent) const;
    QHash<int, QByteArray> roleNames() const;
    void setSource(const QString& source);
    const QString &source();
    bool isLoading();
    const QString &maxId() const;
    int count() const;
    int totalCount() const;

    Q_INVOKABLE QJsonValue get(int index) const;
    Q_INVOKABLE QJsonValue first() const;
    Q_INVOKABLE QJsonValue last() const;


    Q_INVOKABLE bool remove(int index) ;
    Q_INVOKABLE void removeSelection() ;

    Q_INVOKABLE void setSelection(int index, bool select = true);
    Q_INVOKABLE void clearSelection();
    Q_INVOKABLE QJsonArray selection();



public slots:
    void setParams(const QJsonObject& params = QJsonObject());
    void setMaxId(const QString& id);


    void load();
    void clear();


protected slots:
    void loadData(QJsonObject data);

signals:
    void sourceChanged();
    void isLoadingChanged();
    void error(int code, QString message);
    void success();
    void maxIdChanged();


protected:
    void createRoleNames();


private:
    QJsonArray mDatas;
    QHash<int, QByteArray> mRoleNames;
    QJsonObject mParams;
    Request * mRequest;
    int mCurrentPage;
    int mTotalCount;
    QSet<int> mSelections;



};

#endif // RESTLISTVIEW_H
