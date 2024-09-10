// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IProfile {
    struct UserProfile {
        string username;
        string bio;
    }
    function setProfile(string memory _username,string memory _bio) external;
    function getProfile(address _user) view external returns (UserProfile memory);
}

contract Twitter{

    struct Tweet{
        uint id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    IProfile profileContract;

    uint public MAX_TWEET_LENGTH = 280;
    
    mapping (address => Tweet[]) public tweets;

    event createTweetEvent(uint id,address author,string content,uint256 timestamp);

    event likedTweetEvent(address liker,address author, uint tweetId,uint likes);

    event unlikedTweetEvent(address liker,address author, uint tweetId,uint likes);

    constructor(address _profileAddress) {
        profileContract = IProfile(_profileAddress);
    }

    modifier onlyRegistered() {
        IProfile.UserProfile memory userProfileTemp = profileContract.getProfile(msg.sender);
        require(bytes(userProfileTemp.username).length>0,"User not registered");
        _;
    }

    modifier tweetExists(uint id,address author) {
        require(tweets[author].length>id,"Tweet does'nt exist");
        _;
    }

    function createTweet(string memory _tweet) public onlyRegistered {

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

    function getAllTweets(address _user) view public returns (Tweet[] memory){
        return tweets[_user];
    }

    function getTweet(uint i) view public returns (Tweet memory){
        return tweets[msg.sender][i];
    }

    function changeTweetLength(uint newLength) public {
        MAX_TWEET_LENGTH = newLength;
    }

    function likeTweet(uint id,address author) external tweetExists(id,author) onlyRegistered {
        tweets[author][id].likes++;
        emit likedTweetEvent(msg.sender, author, id, tweets[author][id].likes);
    }

    function unLikeTweet(uint id,address author) external tweetExists(id,author) onlyRegistered {
        require(tweets[author][id].likes>0,"Tweet has no likes");
        tweets[author][id].likes--;
        emit unlikedTweetEvent(msg.sender, author, id, tweets[author][id].likes);
    }

    function getTotalLikes(address _user) view external returns (uint) {
        uint totalLikes = 0;
        Tweet[] memory userTweets = tweets[_user];
        for(uint i=0;i<userTweets.length;i++){
            totalLikes += userTweets[i].likes;
        }
        return totalLikes;
    }
}