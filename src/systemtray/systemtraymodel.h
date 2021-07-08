/***************************************************************************
 *   Copyright (C) 2021 Reion Wong     <aj@cutefishos.com>                 *
 *   Copyright (C) 2020 Konrad Materka <materka@gmail.com>                 *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .        *
 ***************************************************************************/

#ifndef SYSTEMTRAYMODEL_H
#define SYSTEMTRAYMODEL_H

#include <QAbstractListModel>

#include "statusnotifierwatcher.h"
#include "statusnotifieritemsource.h"

class SystemTrayModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        IdRole = Qt::UserRole + 1,
        IconNameRole,
        IconRole,
        TitleRole,
        ToolTipRole
    };

    explicit SystemTrayModel(QObject *parent = nullptr);
    ~SystemTrayModel();

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QHash<int, QByteArray> roleNames() const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    int indexOf(const QString &id);
    StatusNotifierItemSource *findItemById(const QString &id);

    Q_INVOKABLE void leftButtonClick(const QString &id);
    Q_INVOKABLE void rightButtonClick(const QString &id);

private slots:
    void onItemAdded(const QString &service);
    void onItemRemoved(const QString &service);
    void updated(StatusNotifierItemSource *item);

private:
    StatusNotifierWatcher *m_watcher;
    QList<StatusNotifierItemSource *> m_items;
    QString m_hostName;
};

#endif // SYSTEMTRAYMODEL_H
