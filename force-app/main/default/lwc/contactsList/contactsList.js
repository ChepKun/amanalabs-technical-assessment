import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import { getRelatedListRecords } from 'lightning/uiRelatedListApi';

import ACCOUNT_LIST_CLICK_CHANNEL from '@salesforce/messageChannel/AccountListClick__c';

const RELATED_LIST_NAME = 'Contacts';
const OBJECT_NAME = 'Contact';
const OBJECT_FIELD_ID = 'Id';
const OBJECT_FIELD_NAME = 'Name';
const OBJECT_FIELD_TITLE = 'Title';

export default class ContactsList extends LightningElement {

    @wire(MessageContext)
    _messageContext;

    /** @type {Object.<string, string>[]} */
    _columns = [
        { label: 'Name', fieldName: OBJECT_FIELD_NAME },
        { label: 'Title', fieldName: OBJECT_FIELD_TITLE }
    ];

    /** @type {string} */
    _accountId = null;

    /** @type {Object.<string, *>[]} */
    _records = [];

    /** @type {Object.<string, string>[]} */
    get columns() {
        return this._columns;
    }

    /** @type {Object.<string, *>[]} */
    get records() {
        return this._records;
    }

    connectedCallback() {
        subscribe(this._messageContext, ACCOUNT_LIST_CLICK_CHANNEL, message => {
            this._accountId = message?.recordId;
        });
    }

    @wire(getRelatedListRecords, {
        parentRecordId: '$_accountId',
        relatedListId: RELATED_LIST_NAME,
        fields: [`${OBJECT_NAME}.${OBJECT_FIELD_ID}`, `${OBJECT_NAME}.${OBJECT_FIELD_NAME}`, `${OBJECT_NAME}.${OBJECT_FIELD_TITLE}`],
        sortBy: [`${OBJECT_NAME}.${OBJECT_FIELD_NAME}`]
    })
    loadRecords({ data, errors }) {
        if (errors) return console.error(errors);
        if (!data) return;
        this._records = data.records?.map(({fields}) => {
            const record = {};
            for (const field in fields) {
                record[field] = fields[field].value ?? null;
            }
            return record;
        });
    }

}
