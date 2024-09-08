// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Twitter{

    address public owner;

    struct Tweet{
        uint id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    uint public MAX_TWEET_LENGTH = 280;
    
    mapping (address => Tweet[]) public tweets;

    event createTweetEvent(uint id,address author,string content,uint256 timestamp);

    event likedTweetEvent(address liker,address author, uint tweetId,uint likes);

    event unlikedTweetEvent(address liker,address author, uint tweetId,uint likes);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender==owner,"You are not owner to change max tweet length");
        _;
    }

    modifier tweetExists(uint id,address author) {
        require(tweets[author].length>id,"Tweet does'nt exist");
        _;
    }

    function createTweet(string memory _tweet) public {

        require(bytes(_tweet).length <= MAX_TWEET_LENGTH, "Tweet is too long");

        Tweet memory newTweet = Tweet({
            id: tweets[msg.sender].length,
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });

        tweets[msg.sender].push(newTweet);
        emit createTweetEvent(newTweet.id, msg.sender, _tweet, block.timestamp);
    }

    function getAllTweets() view public returns (Tweet[] memory){
        return tweets[msg.sender];
    }

    function getTweet(uint i) view public returns (Tweet memory){
        return tweets[msg.sender][i];
    }

    function changeTweetLength(uint newLength) public onlyOwner {
        MAX_TWEET_LENGTH = newLength;
    }

    function likeTweet(uint id,address author) external tweetExists(id,author) {
        tweets[author][id].likes++;
        emit likedTweetEvent(msg.sender, author, id, tweets[author][id].likes);
    }

    function unLikeTweet(uint id,address author) external tweetExists(id,author) {
        require(tweets[author][id].likes>0,"Tweet has no likes");
        tweets[author][id].likes--;
        emit unlikedTweetEvent(msg.sender, author, id, tweets[author][id].likes);
    }
}