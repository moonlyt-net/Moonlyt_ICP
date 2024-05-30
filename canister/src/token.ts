import { bool, nat64, text } from 'azle';

type Account = {
    address: string;
    balance: nat64;
};

type State = {
    accounts: {
        [key: string]: Account;
    };
    name: string;
    ticker: string;
    totalSupply: nat64;
};

let state: State = {
    accounts: {},
    name: '',
    ticker: '',
    totalSupply: 0n
};

export function initializeSupply(
    name: text,
    originalAddress: text,
    ticker: text,
    totalSupply: nat64
): bool {
    state = {
        ...state,
        accounts: {
            [originalAddress]: {
                address: originalAddress,
                balance: totalSupply
            }
        },
        name,
        ticker,
        totalSupply
    };

    return true;
}

export function transfer(
    fromAddress: text,
    toAddress: text,
    amount: nat64
): bool {
    if (state.accounts[toAddress] === undefined) {
        state.accounts[toAddress] = {
            address: toAddress,
            balance: 0n
        };
    }

    state.accounts[fromAddress].balance -= amount;
    state.accounts[toAddress].balance += amount;

    return true;
}

export function balance(address: text): nat64 {
    return state.accounts[address]?.balance ?? 0n;
}

export function ticker(): text {
    return state.ticker;
}

export function name(): text {
    return state.name;
}

export function totalSupply(): nat64 {
    return state.totalSupply;
}
