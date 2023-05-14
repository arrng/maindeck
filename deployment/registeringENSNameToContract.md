# Set ENS Name on contract	

1. Go to app.ens.domains
2. Go to the name
3. Go to Records
4. Edit records
5. Click address
6. Enter the contract address
7. Save, sign transaction
8. Wait for it to complete
9. Close the dialogue when complete
10. Go to More
11. Ownership -> Send
12. Leave make owner selected, un-toggle make manager
13. Enter the contract address
14. Open wallet (odd way to say send but whatever
15. Wait to complete
16. Hit done
17. Go to the contract on etherscan / remix
18. Set the ENS reverse registrar (setENSReverseRegistrar) These change, see here for the latest: https://discuss.ens.domains/t/namewrapper-updates-including-testnet-deployment-addresses/14505
19. Wait for that to complete
20. Call setENSName with the full name including the .eth
21. You are done