didWin: public(bool)
choiceIsHead: public(bool)
senderUint: uint256
groupA: Bytes[8]
groupB: Bytes[8]

@external
def __init__():

    # each of these values represents a possible character value in an Ethereum address, there are 16 in total, so I am splitting them into 2 groups of 8
    # each value has an equal chance of appearing so the probability of a value from a particular group being called is 50% */

    self.groupA = b"\x00\x01\x02\x03\x04\x05\x06\x07"
    self.groupB = b"\x08\x09\x61\x62\x63\x64\x65\x66"

    
  
@internal
def fiftyFiftyRandomNumberFunction(senderUint: uint256) -> bool: /* True and False are being returned randomly with a 50% chance of each being returned */
    senderString: String[50]
    
    self.senderString = uint2str(senderUint)
    tenthChar: String = self.senderString[10]
    tenthCharBytes = convert(tenthChar, Bytes[1])

    if tenthCharBytes in self.groupA:
        return True
    else:
        return False


/* This example is for a coinflip smart contract where a user gambles on either heads or tails and has exactly a 50% chance of winning via our random number function */

      
@external
@payable
def pickHeads() -> String[100]:
    self.choiceIsHead = True
    self.senderUint = convert(msg.sender, uint256)

    if self.coinFlipIsHead(self.senderUint) == self.choiceIsHead:
        self.didWin = True
        return "You won! Sending winnings to "
    else:
        self.didWin = False
        return "You lost! Play again?"

@external
@payable
def pickTails() -> String[100]:
    senderUint: uint256 = convert(msg.sender, uint256)
    self.choiceIsHead = False

    if self.coinFlipIsHead(self.senderUint) == self.choiceIsHead:
        self.didWin = True
        return "You won! Sending winnings to"
    else:
        self.didWin = False
        return "You lost! Sending winnings to"
