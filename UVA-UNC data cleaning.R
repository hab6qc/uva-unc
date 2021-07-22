x <- scan("UVa.txt",what="",sep="\n")


x

x1 <- strsplit(x,"\t")

unlist(lapply(x1,length))

## extract year

s <-  x1[[1]]

s

s[2]


year <- unlist(lapply(x1,function(s){
                      return(as.numeric(s[2]))
                      }
                      ))


### wait, seems like there is problem

year

x1[[61]]

### only one exception, so handle it by hand.

year[61] <- 1956


#### extract location

s[3]

location <- unlist(lapply(x1,function(s){
                      return(s[3])
                      }
                      ))

location

## Winner
s
s[4]

winner <- unlist(lapply(x1,function(s){
                      return(s[4])
                      }
                      ))

winner

### need to get rank

tmp <- winner[52]
tmp2 <- winner[1]
### match the pattern #digits+space

gsub(pattern="#\\d+ ",replacement="",x=tmp)

grep(pattern="#\\d+ ",x=tmp)
grep(pattern="#\\d+ ",x=tmp2)


regexpr(pattern="#\\d+",tmp)
regexpr(pattern="#\\d+",tmp2)

get.rank <- function(string){
    search <- regexpr(pattern="#\\d+",string)
    if(search[1]>0){
        ss <- substr(string,search[1],search[1]+(attributes(search)$match.length-1))

        return(gsub("#","",ss))
    }else{
        return(NA)
    }
}

get.rank(tmp)
get.rank(tmp2)


team.rank <- unlist(lapply(winner,get.rank))

cbind(winner,team.rank)

team.rank <- as.numeric(team.rank)

team.rank

winner.name <- unlist(lapply(winner,function(tmp){
    return(gsub(pattern="#\\d+ ",replacement="",x=tmp))

}))

###

scores <- unlist(lapply(x1,function(s){
                      return(s[5])
                      }
                      ))

scores



strsplit(scores[1],"????")

W.score <- unlist(lapply(scores,function(s){
                      tmp <- strsplit(s,"????")[[1]]
                      return(tmp[1])
                      }
                  ))

L.score <- unlist(lapply(scores,function(s){
                      tmp <- strsplit(s,"????")[[1]]
                      return(tmp[2])
                      }
                  ))

W.score <- as.numeric(W.score)
L.score <- as.numeric(L.score)


dt <- data.frame(year=year, location=location, winner=winner.name,winner.rank=team.rank,winner.score=W.score,loser.score=L.score)

dt
