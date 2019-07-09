local fasttext_embedding_dim = 300;
local glove_embedding_dim = 200;
local lstm_hidden_size = 40;

{
    "dataset_reader": {
        "lazy": false,
        "type": "toxic_comment",
        "token_indexers": {
            "tokens1": {
                "type": "single_id",
            },
            "tokens2": {
                "type": "single_id",
            },
        }
    },
    "train_data_path": "input/jigsaw-toxic-comment-classification-challenge/train_09.csv",
    "validation_data_path": "input/jigsaw-toxic-comment-classification-challenge/valid_01.csv",
    "model": {
        "type": "toxic_comment",
        "text_field_embedder": {
            "token_embedders": {
                "tokens1": {
                    "type": "embedding",
                    "pretrained_file": "input/fatsttext-common-crawl/crawl-300d-2M/crawl-300d-2M.vec",
                    "embedding_dim": fasttext_embedding_dim,
                    "trainable": false
                },
                "tokens2": {
                    "type": "embedding",
                    "pretrained_file": "input/glove-stanford/glove.twitter.27B.200d.txt",
                    "embedding_dim": glove_embedding_dim,
                    "trainable": false
                }
            }
        },
        "seq2seq_encoder": {
            "type": "lstm",
            "input_size": fasttext_embedding_dim + glove_embedding_dim,
            "hidden_size": lstm_hidden_size,
            "num_layers": 2,
            "bidirectional": true,
            "batch_first": true
        },
        "seq2vec_encoder": {
           "type": "swem",
           "embedding_dim": lstm_hidden_size * 2
        },
        "dropout": 0.5,
        "num_labels": 6
    },
    "iterator": {
        "type": "bucket",
        "sorting_keys": [["tokens", "num_tokens"]],
        "batch_size": 128
    },
    "trainer": {
        "optimizer": {
            "type": "adam",
        },
        "num_epochs": 100,
        "grad_norm": 5.0,
        "grad_clipping": 1.0,
        "patience": 3,
        "cuda_device": 0
    }
}
