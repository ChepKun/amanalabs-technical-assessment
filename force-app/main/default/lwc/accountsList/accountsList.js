import { LightningElement, wire } from 'lwc';
import { gql, graphql } from 'lightning/uiGraphQLApi';
import { publish, MessageContext } from 'lightning/messageService';

import ACCOUNT_LIST_CLICK_CHANNEL from '@salesforce/messageChannel/AccountListClick__c';

const OBJECT_NAME = 'Account';
const OBJECT_FIELD_NAME = 'Name';
const OBJECT_FIELD_PHONE = 'Phone';

const GRAPHQL_QUERY = gql`query AccountInfo {
    uiapi {
        query {
            ${OBJECT_NAME} {
                edges {
                    node {
                        Id,
                        ${OBJECT_FIELD_NAME} { value },
                        ${OBJECT_FIELD_PHONE} { value }
                    }
                }
            }
        }
    }
}`;

export default class AccountsList extends LightningElement {

    @wire(MessageContext)
    _messageContext;

    /** @type {Object.<string, string|boolean>[]} */
    _columns = [
        { label: 'Name', name: OBJECT_FIELD_NAME, isLink: true },
        { label: 'Phone', name: OBJECT_FIELD_PHONE }
    ];

    /** @type {Object.<string, *>[]} */
    _records = [];

    /** @type {Object.<string, string>[]} */
    get columns() {
        return this._columns;
    }

    /** @type {Object.<string, *>[]} */
    get rows() {
        const result = [];
        if (!this._records?.length) return result;
        for (const record of this._records) {
            const row = { id: record.Id, fields: [] };
            for (const column of this._columns) {
                const field = {
                    id: `${record.Id}${column.name}`,
                    name: column.name,
                    value: record[column.name],
                    isLink: column.isLink
                };
                row.fields.push(field);
            }
            result.push(row);
        }
        return result;
    }

    @wire(graphql, { query: GRAPHQL_QUERY })
    loadRecords({ data, errors }) {
        if (errors) return console.error(errors);
        if (!data?.uiapi?.query) return;
        const queryResult = data.uiapi.query[OBJECT_NAME]?.edges;
        this._records = queryResult?.map(({ node }) => {
            const result = {};
            for (const field in node) {
                result[field] = typeof node[field] === 'string' ? node[field] : node[field]?.value;
            }
            return result;
        }) ?? [];
    }

    /**
     * @param {Event} event
     */
    handleRowClick(event) {
        if (!event?.target?.dataset) return;
        const { id, name } = event.target.dataset;
        switch (name) {
            case OBJECT_FIELD_NAME:
                publish(this._messageContext, ACCOUNT_LIST_CLICK_CHANNEL, { recordId: id });
                break;
        }
    }

}
