# DAIRY
> Letter sharing Application for participant of MadCamp (centering on inner join and OAuth security)

## Development Information
### ⌛️ Dev. Duration
13, July, 2023 ~ 19, July, 2023

### 👫 The Team
- Jaemin Kim(Korea University, Computer Science & Engineering)
- Yeonguk Jang (KAIST, Computer Science)

### 🌏 Dev. Environment
- ```Java 11```
- Spring Boot
- PyTorch
- Flask
- Flutter

 ## AI
We have created a model that analyzes emotions in diary entries and classifies them into seven categories: [불안, 당황, 분노, 슬픔, 중립, 행복, 혐오].
 
 ### Dataset
 감성대화 말뭉치 (https://aihub.or.kr/aidata/7978)
 <img width="1419" alt="스크린샷 2023-07-19 오후 8 17 25" src="https://github.com/goodjm0698/madcampweek3/assets/64831392/4f7b52f0-99f3-49b0-94a0-6afb9bf8b60c">
 
 ### Model 
 Emotion classification using the PyTorch library and the KoBERT model.
 
 ### Data Preprocessing
 - Utilizing the tokenization function from the Transformer-based KoBERT model to tokenize and vectorize the given text.
 - Multi-category classification for the seven emotions.
 <img width="238" alt="스크린샷 2023-07-19 오후 8 19 10" src="https://github.com/goodjm0698/madcampweek3/assets/64831392/5b700b02-44af-431b-8225-a10405b8b760">
 
 ## Main Function
 ### Section 1. User Handling
 - Login
 - Sign up

<img src="https://github.com/goodjm0698/madcampweek3/assets/64831392/dc03f987-ec86-498a-bd8e-6d281de383e8" width="500">
<img src="https://github.com/goodjm0698/madcampweek3/assets/64831392/0f783979-d2e3-4144-af72-aaccf5c7388b" width="500">


### Section 2. Write Diary
- Write diary by text
- Write diary by voice

<img src="https://github.com/goodjm0698/madcampweek3/assets/64831392/a8b3c422-e923-4e1b-8690-b378848165c2" width="500">
<img src="https://github.com/goodjm0698/madcampweek3/assets/64831392/04deb431-8268-44fb-bf1a-65159f8bea71" width="500">
<img src="https://github.com/goodjm0698/madcampweek3/assets/64831392/61f7f25d-3500-4a13-bc3a-4849f7de0d3b" width="500">
<img src="https://github.com/goodjm0698/madcampweek3/assets/64831392/7f9a80fd-6c2e-446f-8243-b1d9c28f1ddc" width="500">



### Section 3. Calendar
- Show the diary written for each date.
- Diary entry written on that date and emotions analyzed by AI.

<img src="https://github.com/goodjm0698/madcampweek3/assets/64831392/223322f7-35e6-4fe7-a952-50d4060ce996" width="500">
<img src="https://github.com/goodjm0698/madcampweek3/assets/64831392/1f2a72f1-3e77-4a0b-b475-6dc4fb2056e4" width="500">

### Section 4. Emotional statistics
- Emotional statistics recorded by me.
- Emotional statistics analyzed by AI.

<img src="https://github.com/goodjm0698/madcampweek3/assets/64831392/ac3408ad-32f8-4543-a4eb-13f9d8438040" width="500">
<img src="https://github.com/goodjm0698/madcampweek3/assets/64831392/0f1ca37d-0bd6-4f84-85c9-9fad97df1df8" width="500">
