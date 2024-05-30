import { Principal, nat64 } from 'azle';
import { getInvestors, getNFTMetadata, getNFTOwner, getInvestorTokenBalance, getNFTTokens, getNFTAuthor, getNFT } from './nft';

type RevenuePool = {
    amount: bigint;
};

type RevenueShare = {
    recipient: Principal;
    amount: bigint;
};

let revenueShares: RevenueShare[] = [];
let revenuePool: RevenuePool = { amount: 0n };

export function weeklySettlement(
    totalRevenue: bigint,
    creator: Principal,
    tokenId: bigint,
): void {
    const nftOwner = getNFTOwner(tokenId);
    const investors = getInvestors(tokenId);

    if (!nftOwner || !investors) {
        throw new Error('NFT not found or investors not available');
    }

    const creatorShare = totalRevenue / 70n;
    distributeToRecipient(creator, creatorShare);
    
    const investorShare = totalRevenue / 30n;
    distributeToInvestors(investors, investorShare);

    const remainder = totalRevenue - creatorShare - investorShare;
    revenuePool.amount += remainder;
}

function distributeToRecipient(recipient: Principal, amount: bigint): void {
    revenueShares.push({ recipient, amount });
}

export function distributeToInvestors(investors: Map<Principal, { amount: number; activityPoints: Map<string, number> }>, amount: bigint): void {
    let totalAmount = 0;
    for (const { amount } of investors.values()) {
        totalAmount += amount;
    }

    let totalActivityPoints = 0;
    for (const { activityPoints } of investors.values()) {
        for (const points of activityPoints.values()) {
            totalActivityPoints += points;
        }
    }
    for (const [investor, { amount, activityPoints }] of investors) {
        const shareByAmount = (BigInt(amount) / BigInt(totalAmount)) * BigInt(amount);
        let shareByActivityPoints = 0n;
        for (const points of activityPoints.values()) {
            shareByActivityPoints += (BigInt(points) / BigInt(totalActivityPoints)) * BigInt(amount);
        }
        const totalShare = shareByAmount + shareByActivityPoints;

        distributeToRecipient(investor, totalShare);
    }
}

export function getRevenuePool(): RevenuePool {
    return revenuePool;
}
export function distributeMonthlyRevenueToAuthors(): void {
    const nftTokens = getNFTTokens();

    nftTokens.forEach((nft) => {
        const author = getNFTAuthor(nft.tokenId);
        if (author) {
            const monthlyRevenue = nft.salesRevenuePool / 24n; 
            decreaseNFTSalesRevenuePool(nft.tokenId, monthlyRevenue);
            distributeToAuthor(author, monthlyRevenue);
        }
    });
}

export function decreaseNFTSalesRevenuePool(tokenId: nat64, amount: bigint): void {
    const nft = getNFT(tokenId);
    if (nft) {
        nft.salesRevenuePool -= amount;
    }
}

export function distributeToAuthor(author: Principal, amount: bigint): void {
    revenueShares.push({ recipient: author, amount });
}


export function getRevenueShares(): RevenueShare[] {
    return revenueShares;
}
