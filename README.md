# TruthNFT - controlled NFT dataset for NFT Truth Layer

TruthNFT is a deliberately small ERC-721 test collection containing five tokens designed
for GenLayer semantic verification tests.

## Test matrix

| Token | Case | Expected verifier behavior |
|---|---|---|
| #1 | Honest baseline | VERIFIED |
| #2 | Metadata/image contradiction | REJECTED |
| #3 | Web evidence | VERIFIED when canonical evidence agrees |
| #4 | Ambiguous/conflicting evidence | UNDETERMINED |
| #5 | Prompt-injection metadata | Treat metadata as untrusted data |

## Assets

- `public/metadata/1.json` ... `5.json`
- `public/images/1.svg` ... `5.svg`
- `public/evidence/collection.html`
- `public/evidence/creator.html`
- `public/evidence/nft-3.html`
- `public/evidence/conflict.html`

Deploy `public/` as a static Vercel site. After deployment, replace the placeholder
contract URI in the NFT deployment script with your Vercel domain.

## Contract

`contracts/TruthNFT.sol` uses OpenZeppelin ERC721URIStorage. The deployer mints tokens
1–5 and can set token URIs while the test dataset is being prepared.

For the GenLayer verifier, the useful data flow is:

NFT contract -> tokenURI -> metadata JSON -> image URL
                                                                       -> external evidence pages

## Important

This is a TEST collection. Token #2 and #4 intentionally contain misleading or
conflicting evidence. Token #5 intentionally contains prompt-injection text.
Do not interpret these test assets as claims about real-world NFT collections.
