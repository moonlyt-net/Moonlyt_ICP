import { nat64 } from 'azle';
import { getNFT } from './nft';


export function setActivityScore(tokenId: nat64, activity: string, score: number): void {
    const nft = getNFT(tokenId);
    if (nft) {
        const metadata = nft.metadata;
        if (metadata) {
            metadata.activityScores.set(activity, score);
        }
    }
}

export function getActivityScore(tokenId: nat64, activity: string): number | undefined {
    const nft = getNFT(tokenId);
    if (nft) {
        const metadata = nft.metadata;
        if (metadata) {
            return metadata.activityScores.get(activity);
        }
    }
    return undefined;
}

export function increaseActivityScore(tokenId: nat64, activity: string, amount: number): void {
    const currentScore = getActivityScore(tokenId, activity);
    if (currentScore !== undefined) {
        setActivityScore(tokenId, activity, currentScore + amount);
    }
}

export function decreaseActivityScore(tokenId: nat64, activity: string, amount: number): void {
    const currentScore = getActivityScore(tokenId, activity);
    if (currentScore !== undefined) {
        setActivityScore(tokenId, activity, currentScore - amount);
    }
}
