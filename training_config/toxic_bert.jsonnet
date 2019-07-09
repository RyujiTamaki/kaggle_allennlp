local bert_model = "bert-base-uncased";

{
    "dataset_reader": {
        "lazy": false,
        "type": "toxic_comment",
        "tokenizer": {
            "word_splitter": "bert-basic"
        },
        "token_indexers": {
            "bert": {
                "type": "bert-pretrained",
                "pretrained_model": bert_model,
                "max_pieces": 128,
            }
        }
    },
    "train_data_path": "input/jigsaw-toxic-comment-classification-challenge/train_09.csv",
    "validation_data_path": "input/jigsaw-toxic-comment-classification-challenge/valid_01.csv",
    "model": {
        "type": "toxic_bert",
        "bert_model": bert_model,
        "num_labels": 6
    },
    "iterator": {
        "type": "bucket",
        "sorting_keys": [["tokens", "num_tokens"]],
        "batch_size": 32
    },
    "trainer": {
        "optimizer": {
            "type": "bert_adam",
            "lr": 2e-5
        },
        "num_serialized_models_to_keep": 1,
        "num_epochs": 3,
        "grad_norm": 5.0,
        "grad_clipping": 1.0,
        "patience": 5,
        "cuda_device": 0
    }
}
