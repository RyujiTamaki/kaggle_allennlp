## kaggle_allennlp
kaggle用のallennlpのコードを置くライブラリ
現在 https://www.kaggle.com/c/jigsaw-toxic-comment-classification-challenge のみ

### data download
```
kaggle competitions download -c jigsaw-toxic-comment-classification-challenge
kaggle datasets download -d facebook/fatsttext-common-crawl
kaggle datasets download -d nishitian/glove-stanford
```

### train command
```
$ allennlp train training_config/toxic_boe.jsonnet -s tmp/boe --include-package kaggle_allennlp
```
