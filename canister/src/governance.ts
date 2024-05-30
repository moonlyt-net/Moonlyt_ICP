import { update, query, Principal, text } from 'azle';

type Proposal = {
    proposer: Principal;
    description: text;
    forVotes: number;
    againstVotes: number;
    status: 'Pending' | 'Passed' | 'Rejected';
};

let proposals: Proposal[] = [];

export function createProposal(proposer: Principal, description: text): void {
    proposals.push({ proposer, description, forVotes: 0, againstVotes: 0, status: 'Pending' });
}

export function vote(proposalIndex: number, voteFor: boolean): void {
    const proposal = proposals[proposalIndex];
    if (!proposal) {
        return;
    }
    if (voteFor) {
        proposal.forVotes++;
    } else {
        proposal.againstVotes++;
    }
}

export function getProposalStatus(proposalIndex: number): 'Pending' | 'Passed' | 'Rejected' {
    const proposal = proposals[proposalIndex];
    if (!proposal) {
        return 'Pending';
    }
    if (proposal.forVotes > proposal.againstVotes) {
        proposal.status = 'Passed';
    } else {
        proposal.status = 'Rejected';
    }
    return proposal.status;
}
