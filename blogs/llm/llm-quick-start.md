---
title:  LLM - 快速上手大语言模型
author: Chenyang Tang
published: true
date: 2025-05-30 11:10:55
tags:
- LLM
categories:
- LLM
---

# LLM - 快速上手大语言模型
前面的文章我们介绍了什么是AI，都是停留在一些概念上面，接下来，我们实际来用几个简单的步骤和代码，来体验一下，快速上手大语言模型。


## 1 环境准备
- Python  3.10 及以上

Python 是一个非常流行的编程语言，广泛应用于数据科学、机器学习、人工智能等领域。 本文也将在 Python 环境下来进行实际操作的演示。 

如果您还没有安装 Python，可以参考 [Python 环境搭建](https://www.runoob.com/python/python-install.html) 下载并安装。  

### 安装依赖包
OpenAI 是一个提供大语言模型的公司，他们也提供了一套 API 来与大语言模型进行交互。 同时也支持其他厂商的大语言模型，比如 DeepSeek 等。
因此我们需要安装 `openai` 库来与 OpenAI 进行交互。 你可以使用以下命令来安装 `openai` 库：
```shell
pip install openai
```

### 启动 Notebook
Notebook 是一个非常方便的工具，可以用来交互式地进行编写和运行代码。 

你可以使用以下命令来启动 Notebook：
```shell
jupyter notebook
```

启动Notebook 后，你会跳转到一个界面，类似于以下的截图：  

![Notebook 界面](https://github.com/tangchenyang/picx-images-hosting/raw/master/image.wispsb20t.webp)

我们点击 `New` 按钮，然后选择 `Python 3` 来创建一个新的 Notebook。  

![新建 Notebook](https://github.com/tangchenyang/picx-images-hosting/raw/master/image.4ub66goojo.webp)

然后在 Notebook 中，你可以开始编写代码了。  

比如我们来编写一个简单的 Python 代码，输出 "Hello, Python"。  
```python
print("Hello, Python")
```

按下 `Shift + 回车键`，代码就会运行，并且你会看到输出 "Hello, Python"。    

![Notebook 运行结果](https://github.com/tangchenyang/picx-images-hosting/raw/master/image.1lc29t2j6o.webp)

如果你本地的情况和上面的截图一样，就表示现在 Python 环境准备好了。

## 2 申请 API KEY
OpenAI 是与大语言模型交互的 API，但是大语言模型是由各个厂商提供的，比如：
- OpenAI 公司的 `GPT-4`、`GPT-3.5`、`GPT-3` 等
- DeepSeek 公司的 `Deepseek-R1` 
- 阿里巴巴公司的 `通义千问(Qwen3)` 
- ...

因此我们需要先去对应的厂商官网申请 API KEY。


例如 [阿里云百炼平台](https://bailian.console.aliyun.com/?tab=model#/model-market/detail/qwen3?modelGroup=qwen3) 为每个用户提供了多个大语言模型的免费使用额度，可以满足我们学习大语言模型的需求。 

![通义千问免费额度](https://github.com/tangchenyang/picx-images-hosting/raw/master/image.lvywp174i.webp)


因此我们可以访问 [阿里云百炼 API-Key](https://bailian.console.aliyun.com/?tab=model#/api-key) 来申请阿里厂商的 API KEY。

![阿里云百炼 - 创建 API KEY](https://github.com/tangchenyang/picx-images-hosting/raw/master/image.8s3jn6tc9x.webp)

创建好后，点击 `查看` 按钮，就可以看到 API KEY 的信息了。 然后将其复制下来，后面在代码中使用。  

![阿里云百炼 - 查看 API KEY](https://github.com/tangchenyang/picx-images-hosting/raw/master/image.4g4qfndbk0.png)

## 3 与 AI 对话
Python 环境准备好了，API KEY 也申请好了，接下来就可以与 OpenAI 进行交互了。 我们先回到前面打开的 Notebook 页面中，准备运行我们的AI代码。 

首先需要导入 `openai` 库，然后创建一个 `OpenAI` 的客户端：在 Notebook 中输入以下代码片段，并按 Shift + 回车执行
```python
BASE_URL="https://dashscope.aliyuncs.com/compatible-mode/v1" # 阿里云的 API 地址
API_KEY="***" # 替换为你的 API KEY

from openai import OpenAI
client = OpenAI(base_url=BASE_URL, api_key=API_KEY)
print(client)
```
将会输出类似以下的输出，即代表成功创建了 OpenAI 的客户端：
```text
<openai.OpenAI object at 0x10952b790>
```

然后我们使用阿里的 `通义千问-Turbo (qwen-turbo-latest)` 模型来发起一个对话，向 AI 发送打招呼的消息 "你好"

```python
MODEL="qwen-turbo-latest"

```
我们将会看到AI的回答，比如：
```text
你好！很高兴见到你。有什么我可以帮你的吗？😊
```


为了方便我们向AI发送不同的消息，我们可以上面的代码封装成一个 chat 函数，函数的输入是我们发送给 AI 的消息，函数的返回值是 AI 的回复。   

```python
BASE_URL="https://dashscope.aliyuncs.com/compatible-mode/v1" # 阿里云的 API 地址
API_KEY="***" # 替换为你的 API KEY

from openai import OpenAI
client = OpenAI(base_url=BASE_URL, api_key=API_KEY)

def chat(message):
    response = client.chat.completions.create(
        model=MODEL,
        messages=[
            {"role": "user", "content": message}
        ],
    )
    response_content = response.choices[0].message.content
    return response_content
```

然后我们就可以使用这个 `chat` 函数来与 AI 进行对话了。比如：
- 发送 "今天天气真不错"  
  ```python
  print(chat("今天天气真不错"))
  ```
  
- AI 回复： 
   ```text
   是啊，今天的天气确实很棒！阳光明媚，微风轻拂，正是出去走走、放松心情的好时候。你有什么计划吗？要不要一起去公园散步或者喝杯咖啡？
   ```
  
- 发送 "什么咖啡最好喝"  
  ```python
  print(chat("简单说一下喝咖啡的好处"))
  ```
  
- AI 回复
  ```python
  喝咖啡有以下一些好处：
  
  1. **提神醒脑**：咖啡中的咖啡因能刺激中枢神经系统，帮助提高注意力、集中力和反应速度。
  
  2. **增强体力与运动表现**：咖啡因可以促进脂肪分解，为身体提供能量，有助于提升运动表现。
  
  3. **抗氧化作用**：咖啡含有丰富的抗氧化物质，有助于抵抗自由基，减缓细胞老化。
  
  4. **降低某些疾病风险**：适量饮用咖啡可能降低患2型糖尿病、帕金森病、肝病和某些癌症的风险。
  
  5. **改善情绪**：咖啡因可以促进多巴胺分泌，有助于改善心情，减少抑郁风险。
  
  不过要注意的是，过量饮用咖啡可能导致失眠、心悸、胃部不适等问题，建议每天摄入量不超过400毫克咖啡因（约3-4杯普通咖啡）。
  ```

以上就是一个最简单的与 OpenAI 进行交互的示例，希望这个示例能帮助你快速上手大语言模型，非常容易动手实践吧？ 

如果有任何问题或需要进一步的帮助，欢迎在评论区留言。

