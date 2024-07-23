import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/common/channel_color.dart';
import 'package:one_chatgpt_flutter/common/log.dart';
import 'package:one_chatgpt_flutter/models/model_config.dart';
import 'package:one_chatgpt_flutter/models/response/channel_model.dart';
import 'package:one_chatgpt_flutter/state/model_config.dart';
import 'package:provider/provider.dart';

class ModelSetting extends StatefulWidget {
  const ModelSetting({super.key});

  @override
  State<ModelSetting> createState() => _ModelSettingState();
}

class _ModelSettingState extends State<ModelSetting> {
  List<DropdownMenuItem<String>> createDropdownMenuItems(
      List<String> modelList) {
    return modelList.map((String modelName) {
      return DropdownMenuItem<String>(
        alignment: AlignmentDirectional.center,
        value: modelName,
        child: Text(modelName),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('模型设置'),
        actions: <Widget>[
          // 修改标题按钮
          TextButton(
            onPressed: () {
              Provider.of<ModelConfigProvider>(context, listen: false).reset();
            },
            child: const Text(
              "重置",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildModelSettingListTile(context),
              const SizedBox(height: 10),
              // 将最大令牌数和历史消息数合并到一个 ListTile 中
              Row(
                children: [
                  Expanded(
                    child: _buildMaxTokensListTile(context),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildHistoryMessageCountListTile(context),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildRandomnessListTile(context),
              const SizedBox(height: 10),
              _buildNuclearSamplingListTile(context),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModelSettingListTile(BuildContext context) {
    return Selector<ModelConfigProvider, ChannelModel>(
      selector: (context, model) => model.currentModel,
      builder: (context, currentModel, child) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '模型',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Text(
                "当前使用的模型",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              DropdownButton<String>(
                value: currentModel.model,
                borderRadius: BorderRadius.circular(10),
                underline: Container(
                  height: 0, // 隐藏下划线
                ),
                alignment: AlignmentDirectional.center,
                items: Provider.of<ModelConfigProvider>(context, listen: false)
                    .channelModels
                    .map((data) {
                  return DropdownMenuItem<String>(
                    alignment: AlignmentDirectional.center,
                    value: data.model,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '（${data.label}）',
                          style: TextStyle(
                              color: ChannelColor.getColorFromName(data.color),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data.model,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? value) {
                  if (value != null) {
                    Provider.of<ModelConfigProvider>(context, listen: false)
                        .updateModel(model: value);
                  }
                },
                hint: const Text('请选择模型'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMaxTokensListTile(BuildContext context) {
    return Selector<ModelConfigProvider, ModelConfig>(
      selector: (context, model) => model.currentModelConfig,
      builder: (context, currentModelConfig, child) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '最大令牌数',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Text(
                "单次交互最大Token数",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 46,
                child: TextField(
                  controller: TextEditingController(
                    text: currentModelConfig.maxTokens.toString(),
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold, // 设置字体加重为 FontWeight.bold
                  ),
                  scrollPadding: const EdgeInsets.all(0),
                  maxLength: 5,
                  decoration: const InputDecoration(
                    counter: SizedBox.shrink(),
                    hintText: '最大令牌数',
                    border: InputBorder.none,
                  ),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (String? value) {
                    if (value != null) {
                      Provider.of<ModelConfigProvider>(context, listen: false)
                          .updateModelConfig(maxTokens: int.parse(value));
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRandomnessListTile(BuildContext context) {
    return Selector<ModelConfigProvider, ModelConfig>(
      selector: (context, model) => model.currentModelConfig,
      builder: (context, currentModelConfig, child) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '随机性',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Text(
                "值越大，回复越随机",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              Slider(
                inactiveColor: Colors.grey[100],
                value: currentModelConfig.temperature ?? 0,
                max: 1.0,
                min: 0.0,
                divisions: 10,
                label: currentModelConfig.temperature.toString(),
                onChanged: (double value) {
                  Provider.of<ModelConfigProvider>(context, listen: false)
                      .updateModelConfig(
                    temperature: value,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNuclearSamplingListTile(BuildContext context) {
    return Selector<ModelConfigProvider, ModelConfig>(
      selector: (context, model) => model.currentModelConfig,
      builder: (context, currentModelConfig, child) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '核采样',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Text(
                "与随机性类似，但不要和随机性一起更改",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              Slider(
                inactiveColor: Colors.grey[100],
                value: currentModelConfig.topP ?? 0,
                max: 1.0,
                min: 0.0,
                divisions: 10,
                label: currentModelConfig.topP.toString(),
                onChanged: (double value) {
                  Provider.of<ModelConfigProvider>(context, listen: false)
                      .updateModelConfig(topP: value);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHistoryMessageCountListTile(BuildContext context) {
    return Selector<ModelConfigProvider, ModelConfig>(
      selector: (context, model) => model.currentModelConfig,
      builder: (context, currentModelConfig, child) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '历史消息数',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Text(
                "每次请求携带的历史消息数",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              Slider(
                inactiveColor: Colors.grey[100],
                value: currentModelConfig.historyMessages ?? 0,
                max: 10.0,
                min: 0.0,
                divisions: 10,
                label: currentModelConfig.historyMessages.toString(),
                onChanged: (double value) {
                  Provider.of<ModelConfigProvider>(context, listen: false)
                      .updateModelConfig(historyMessages: value);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
