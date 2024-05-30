import { Principal, nat64 } from 'azle';

export type NFTMetadata = {
    name: string;
    description: string;
    imageUrl: string;
    mandatoryActivities: string[];
    activityScores: Map<string, number>;
};

type InvestorInfo = { amount: number; activityPoints: Map<string, number> };

type NFT = {
    tokenId: nat64;
    owner: Principal;
    author: Principal;
    metadata: NFTMetadata;
    investors: Map<Principal, InvestorInfo>;
    salesRevenuePool: bigint;
};

let nftTokens: Map<nat64, NFT> = new Map();

export function mintNFT(metadata: NFTMetadata, owner: Principal, author: Principal, investors: Map<Principal, number>): nat64 {
    const tokenId: nat64 = BigInt(nftTokens.size + 1);
    const nft: NFT = {
        tokenId,
        owner,
        author,
        metadata: { ...metadata, activityScores: new Map(metadata.activityScores) },
        investors: new Map(),
        salesRevenuePool: 0n
    };

    investors.forEach((amount, investor) => {
        nft.investors.set(investor, { amount, activityPoints: new Map() });
    });

    metadata.mandatoryActivities.forEach(activity => {
        nft.metadata.activityScores.set(activity, 0);
    });

    nftTokens.set(tokenId, nft);
    return tokenId;
}

export function getNFTTokens(): Map<nat64, NFT> {
    return nftTokens;
}

export function getNFT(tokenId: nat64): NFT | undefined {
    return nftTokens.get(tokenId);
}

export function getNFTMetadata(tokenId: nat64): NFTMetadata | undefined {
    const nft = nftTokens.get(tokenId);
    return nft ? nft.metadata : undefined;
}

export function getNFTOwner(tokenId: nat64): Principal | undefined {
    const nft = nftTokens.get(tokenId);
    return nft ? nft.owner : undefined;
}

export function getNFTAuthor(tokenId: nat64): Principal | undefined {
    const nft = nftTokens.get(tokenId);
    return nft ? nft.author : undefined;
}

export function getInvestors(tokenId: nat64): Map<Principal, InvestorInfo> | undefined {
    const nft = nftTokens.get(tokenId);
    return nft ? nft.investors : undefined;
}

export function getInvestorTokenBalance(investor: Principal, tokenId: nat64): number {
    const nft = nftTokens.get(tokenId);
    if (!nft) return 0;
    return nft.investors.get(investor)?.amount || 0;
}

export function getInvestorActivityPoints(investor: Principal, tokenId: nat64, activityType: string): number {
    const nft = nftTokens.get(tokenId);
    if (!nft) return 0;
    return nft.investors.get(investor)?.activityPoints.get(activityType) || 0;
}

export function getNFTSalesRevenuePool(tokenId: nat64): bigint | undefined {
    const nft = nftTokens.get(tokenId);
    return nft ? nft.salesRevenuePool : undefined;
}

export function increaseNFTSalesRevenuePool(tokenId: nat64, amount: bigint): void {
    const nft = nftTokens.get(tokenId);
    if (nft) {
        nft.salesRevenuePool += amount;
    }
}

export function decreaseNFTSalesRevenuePool(tokenId: nat64, amount: bigint): void {
    const nft = nftTokens.get(tokenId);
    if (nft && nft.salesRevenuePool >= amount) {
        nft.salesRevenuePool -= amount;
    }
}

export function transferNFT(from: Principal, to: Principal, tokenId: nat64): boolean {
    const nft = nftTokens.get(tokenId);
    if (!nft || nft.owner !== from) return false;

    nft.owner = to;
    return true;
}

exports = {
    mintNFT,
    getNFTTokens,
    getNFT,
    getNFTMetadata,
    getNFTOwner,
    getNFTAuthor,
    getInvestors,
    getInvestorTokenBalance,
    getInvestorActivityPoints,
    getNFTSalesRevenuePool,
    increaseNFTSalesRevenuePool,
    decreaseNFTSalesRevenuePool,
}