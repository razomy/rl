#
Concrete AI Providers, neural Layers, Optimizers, loss Functions & RL Algorithms
#

ModelModality "text" | "vision" | "audio" | "video" | "multimodal" | "embedding" | "code" | "reinforcement" | "tabular" | "graph" | "3d"
ModelProvider "openai" | "anthropic" | "google" | "meta" | "mistral" | "deepseek" | "cohere" | "xai" | "huggingface" | "local"

ActivationFunction "ReLU" | "LeakyReLU" | "GELU" | "SiLU" | "Swish" | "Sigmoid" | "Tanh" | "Softmax" | "Softplus" | "ELU" | "Mish"
LossFunction       "CrossEntropy" | "BinaryCrossEntropy" | "MSE" | "MAE" | "Huber" | "KLDivergence" | "Contrastive" | "Triplet" | "CTC" | "Focal"
OptimizerType      "SGD" | "Adam" | "AdamW" | "RMSprop" | "Adagrad" | "Lion" | "Muon" | "SOAP" | "LBFGS"
PrecisionFormat    "FP64" | "FP32" | "TF32" | "FP16" | "BF16" | "FP8_E4M3" | "FP8_E5M2" | "INT8" | "INT4" | "NF4"

NeuralLayerType
  "Linear" | "Conv1D" | "Conv2D" | "Conv3D" | "DepthwiseConv2D" | "TransposeConv2D"
  | "MaxPool" | "AvgPool" | "AdaptiveAvgPool"
  | "BatchNorm" | "LayerNorm" | "RMSNorm" | "GroupNorm"
  | "Dropout" | "Embedding" | "PositionalEncoding" | "RoPE"
  | "RNN" | "LSTM" | "GRU" | "MambaSSM"
  | "MultiHeadAttention" | "GroupedQueryAttention" | "FlashAttention" | "CrossAttention"
  | "MoERouter" | "FeedForwardSwiGLU" | "ResidualConnection"

RLAlgorithm "DQN" | "PPO" | "SAC" | "TD3" | "DDPG" | "A2C" | "A3C" | "GRPO" | "DPO" | "RLHF" | "AlphaZero" | "MuZero"
