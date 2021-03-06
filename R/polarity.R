# author : Karanpal Singh
# date : 26 Feb 2020


#' Polarity
#'   This method will check and compute the polarity of the text data.
#'   This method will return:
#'   - Number of Positive words
#'   - Number of Negative words
#'
#' @param df_col
#' This method will expect dataframe's column with textual data
#'
#' @return dataframe with one row containing columns for count of positive, negative and neutral words
#'
#' @export
#'
#' @examples
#' df = data.frame(text = c('He is a good guy.This is the worst coffee I had in my life.'))
#' polarity(df$text)


polarity <- function(df_col){



    # loading positive lexicons
    positive_words_df = readr::read_csv('http://ptrckprry.com/course/ssd/data/positive-words.txt', skip = 32, col_names = 'words')
    positive_words = list(positive_words_df$words)[[1]]

    # loading negative lexicons
    negative_words_df = readr::read_csv('http://ptrckprry.com/course/ssd/data/negative-words.txt', skip = 33, col_names = 'words')
    negative_words = list(negative_words_df$words)[[1]]


    # concat for processing simplicity
    all_messages = stringi::stri_paste_list(list(df_col), sep = ", ", collapse = "")


    # sensing tokens
    word_tokens = (tokenizers::tokenize_words(all_messages))[[1]]



    # counting positive words
    positive_word_count = 0
    for(i in word_tokens){
        if(i %in% positive_words){
            positive_word_count = positive_word_count + 1
        }
        else{
            positive_word_count = positive_word_count
        }
    }

    # counting negative words
    negative_word_count = 0
    for(i in word_tokens){
        if(i %in% negative_words){
            negative_word_count = negative_word_count + 1
        }
        else{
            negative_word_count = negative_word_count
        }
    }

    dplyr::tibble('positive_words' = positive_word_count, 'negative_words'=negative_word_count)
}


