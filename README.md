# nfl-game-ball

## Overivew

### Why?
Handed a TD ball from fav player.
Show it off. Get no reaction.
Keep in a glass box at home. Get no reaction.
### How?
NFL tags balls with ID.
ID assigned to a digital token (NFT).
Lucky fan verifies ball ID and receives NFT.
### What?
1 contract per game. Each game ball as NFT.
Fan verifies ball ID through NFL website.
NFL transfers game ball NFT to fan wallet.
### Step by step:
1. NFL creates all game ball NFTs that correspond to ids on each game ball (before game starts)
2. Event happens (ex: touchdown scored, game ball given to fan in stands)
3. NFT adds event notes to game ball NFT
4. Fan verifies they have the game ball by verifying game ball id with NFL (ex: through website)
5. NFL updates game ball NFT and transfers to fan
6. Fan showcases verified game ball NFT!

## Play around yourself!

### Mumbai testnet smart contracts:
- GameBalls: [0xbd524e393C02a16A64A44c99Ca3be00250A3cc5D](https://mumbai.polygonscan.com/address/0xbd524e393C02a16A64A44c99Ca3be00250A3cc5D)

### How to interact through PolygonScan
1. Obtain Mumbai MATIC. [FAUCET](https://faucet.polygon.technology/).
2. Create game ball NFT. Use #3 createGameBalls. Inputs: ids_ = array of ids, owner_ = wallet you own. [WRITE CONTRACT](https://mumbai.polygonscan.com/address/0xbd524e393C02a16A64A44c99Ca3be00250A3cc5D#writeContract).
3. Add notes to game ball NFT. Use #1 addNotesToGameBall. Inputs: id_ = one gameBall id from step 2, notes = "TD by Dalvin Cook. Q1. 7:15.". [WRITE CONTRACT](https://mumbai.polygonscan.com/address/0xbd524e393C02a16A64A44c99Ca3be00250A3cc5D#writeContract).
4. Verify game ball (transfer to fan). Use #8 verifyGameBall. Inputs = id_ gameBall id from step 3, fan_ = different wallet you own. Must call using wallet from step 2. [WRITE CONTRACT](https://mumbai.polygonscan.com/address/0xbd524e393C02a16A64A44c99Ca3be00250A3cc5D#writeContract).