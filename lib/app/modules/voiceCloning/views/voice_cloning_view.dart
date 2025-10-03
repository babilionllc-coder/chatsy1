import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chatsy/app/common_widget/common_screen.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/app/common_widget/app_text.dart';
import 'package:chatsy/app/common_widget/common_button.dart';
import 'package:chatsy/app/common_widget/comman_text_field.dart';
import 'package:chatsy/app/common_widget/modern_card.dart';
import 'package:chatsy/extension.dart';
import 'package:chatsy/app/helper/app_colors.dart';
import '../controllers/voice_cloning_controller.dart';

class VoiceCloningView extends GetView<VoiceCloningController> {
  const VoiceCloningView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VoiceCloningController>(
      init: VoiceCloningController(),
      builder: (controller) {
        return CommonScreen(
          title: 'Voice Cloning',
          body: Obx(() {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 17.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.px),
                  
                  // Voice Cloning Header
                  _buildHeader(context),
                  SizedBox(height: 24.px),
                  
                  // Voice Cloning Form
                  _buildCloningForm(context, controller),
                  SizedBox(height: 24.px),
                  
                  // Uploaded Files Section
                  if (controller.uploadedFiles.isNotEmpty) ...[
                    _buildUploadedFilesSection(context, controller),
                    SizedBox(height: 24.px),
                  ],
                  
                  // Cloning Progress
                  if (controller.isCloning.value) ...[
                    _buildCloningProgress(context, controller),
                    SizedBox(height: 24.px),
                  ],
                  
                  // Cloned Voices Section
                  _buildClonedVoicesSection(context, controller),
                  SizedBox(height: 20.px),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return ModernCard(
      padding: EdgeInsets.all(20.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.px),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.px),
                ),
                child: Icon(
                  Icons.record_voice_over,
                  color: AppColors.primary,
                  size: 24.px,
                ),
              ),
              SizedBox(width: 16.px),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      'AI Voice Cloning',
                      fontSize: 18.px,
                      fontWeight: FontWeight.bold,
                      color: AppColors().darkAndWhite,
                    ),
                    SizedBox(height: 4.px),
                    AppText(
                      'Clone any voice using AI technology',
                      fontSize: 14.px,
                      color: AppColors().darkAndWhite.withOpacity(0.7),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.px),
          AppText(
            'Upload 3-5 audio samples (10-30 seconds each) of the voice you want to clone. Our AI will create a digital replica that can speak any text.',
            fontSize: 14.px,
            color: AppColors().darkAndWhite.withOpacity(0.8),
          ),
        ],
      ),
    );
  }

  Widget _buildCloningForm(BuildContext context, VoiceCloningController controller) {
    return ModernCard(
      padding: EdgeInsets.all(20.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            'Voice Cloning Setup',
            fontSize: 16.px,
            fontWeight: FontWeight.bold,
            color: AppColors().darkAndWhite,
          ),
          SizedBox(height: 16.px),
          
          // Voice Name
          AppText(
            'Voice Name',
            fontSize: 14.px,
            fontWeight: FontWeight.w600,
            color: AppColors().darkAndWhite,
          ),
          SizedBox(height: 8.px),
          CommonTextField(
            hintText: 'Enter voice name (e.g., John\'s Voice)',
            controller: TextEditingController(text: controller.voiceName.value),
            onChanged: (value) => controller.voiceName.value = value,
          ),
          SizedBox(height: 16.px),
          
          // Voice Description
          AppText(
            'Description (Optional)',
            fontSize: 14.px,
            fontWeight: FontWeight.w600,
            color: AppColors().darkAndWhite,
          ),
          SizedBox(height: 8.px),
          CommonTextField(
            hintText: 'Describe this voice (e.g., "Deep male voice, professional tone")',
            controller: TextEditingController(text: controller.voiceDescription.value),
            onChanged: (value) => controller.voiceDescription.value = value,
          ),
          SizedBox(height: 16.px),
          
          // Upload Button
          CommonButton(
            onTap: controller.pickAudioFiles,
            title: 'Select Audio Files',
            buttonColor: AppColors.primary,
            textColor: AppColors.white,
            borderRadius: 10.px,
            verticalPadding: 14.px,
          ),
          SizedBox(height: 8.px),
          AppText(
            'Supported formats: WAV, MP3, M4A, FLAC',
            fontSize: 12.px,
            color: AppColors().darkAndWhite.withOpacity(0.6),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadedFilesSection(BuildContext context, VoiceCloningController controller) {
    return ModernCard(
      padding: EdgeInsets.all(20.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                'Uploaded Files (${controller.uploadedFiles.length})',
                fontSize: 16.px,
                fontWeight: FontWeight.bold,
                color: AppColors().darkAndWhite,
              ),
              TextButton(
                onPressed: controller.clearUploadedFiles,
                child: AppText(
                  'Clear All',
                  fontSize: 14.px,
                  color: AppColors.error,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.px),
          ...controller.uploadedFiles.asMap().entries.map((entry) {
            final index = entry.key;
            final file = entry.value;
            return Container(
              margin: EdgeInsets.only(bottom: 8.px),
              padding: EdgeInsets.all(12.px),
              decoration: BoxDecoration(
                color: AppColors().bgColor3,
                borderRadius: BorderRadius.circular(8.px),
                border: Border.all(
                  color: AppColors.grey,
                  width: 1.px,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.audiotrack,
                    color: AppColors.primary,
                    size: 20.px,
                  ),
                  SizedBox(width: 12.px),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          file.path.split('/').last,
                          fontSize: 14.px,
                          fontWeight: FontWeight.w500,
                          color: AppColors().darkAndWhite,
                        ),
                        AppText(
                          '${(file.lengthSync() / 1024 / 1024).toStringAsFixed(2)} MB',
                          fontSize: 12.px,
                          color: AppColors().darkAndWhite.withOpacity(0.6),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => controller.removeUploadedFile(index),
                    icon: Icon(
                      Icons.close,
                      color: AppColors.error,
                      size: 20.px,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          SizedBox(height: 16.px),
          CommonButton(
            onTap: controller.isCloning.value ? null : controller.cloneVoice,
            title: controller.isCloning.value ? 'Cloning Voice...' : 'Clone Voice',
            buttonColor: AppColors.success,
            textColor: AppColors.white,
            borderRadius: 10.px,
            verticalPadding: 14.px,
          ),
        ],
      ),
    );
  }

  Widget _buildCloningProgress(BuildContext context, VoiceCloningController controller) {
    return ModernCard(
      padding: EdgeInsets.all(20.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            'Voice Cloning Progress',
            fontSize: 16.px,
            fontWeight: FontWeight.bold,
            color: AppColors().darkAndWhite,
          ),
          SizedBox(height: 16.px),
          LinearProgressIndicator(
            value: controller.cloningProgress.value,
            backgroundColor: AppColors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
          SizedBox(height: 8.px),
          AppText(
            controller.cloningStatus.value,
            fontSize: 14.px,
            color: AppColors().darkAndWhite.withOpacity(0.8),
          ),
          SizedBox(height: 8.px),
          AppText(
            '${(controller.cloningProgress.value * 100).toInt()}% Complete',
            fontSize: 12.px,
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  Widget _buildClonedVoicesSection(BuildContext context, VoiceCloningController controller) {
    return ModernCard(
      padding: EdgeInsets.all(20.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            'Your Cloned Voices (${controller.clonedVoices.length})',
            fontSize: 16.px,
            fontWeight: FontWeight.bold,
            color: AppColors().darkAndWhite,
          ),
          SizedBox(height: 16.px),
          if (controller.clonedVoices.isEmpty)
            Container(
              padding: EdgeInsets.all(20.px),
              decoration: BoxDecoration(
                color: AppColors().bgColor3,
                borderRadius: BorderRadius.circular(8.px),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.record_voice_over_outlined,
                    size: 48.px,
                    color: AppColors().darkAndWhite.withOpacity(0.3),
                  ),
                  SizedBox(height: 12.px),
                  AppText(
                    'No cloned voices yet',
                    fontSize: 14.px,
                    color: AppColors().darkAndWhite.withOpacity(0.6),
                  ),
                  AppText(
                    'Clone your first voice using the form above',
                    fontSize: 12.px,
                    color: AppColors().darkAndWhite.withOpacity(0.4),
                  ),
                ],
              ),
            )
          else
            ...controller.clonedVoices.map((voice) {
              return Container(
                margin: EdgeInsets.only(bottom: 12.px),
                padding: EdgeInsets.all(16.px),
                decoration: BoxDecoration(
                  color: AppColors().bgColor3,
                  borderRadius: BorderRadius.circular(8.px),
                  border: Border.all(
                    color: AppColors.grey,
                    width: 1.px,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.px),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.px),
                      ),
                      child: Icon(
                        Icons.record_voice_over,
                        color: AppColors.success,
                        size: 20.px,
                      ),
                    ),
                    SizedBox(width: 12.px),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            voice.name,
                            fontSize: 14.px,
                            fontWeight: FontWeight.w600,
                            color: AppColors().darkAndWhite,
                          ),
                          if (voice.description != null) ...[
                            SizedBox(height: 2.px),
                            AppText(
                              voice.description!,
                              fontSize: 12.px,
                              color: AppColors().darkAndWhite.withOpacity(0.6),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => controller.testClonedVoice(voice.voiceId, "Hello, this is a test of the cloned voice."),
                          icon: Icon(
                            Icons.play_arrow,
                            color: AppColors.primary,
                            size: 20.px,
                          ),
                        ),
                        IconButton(
                          onPressed: () => _showDeleteDialog(context, controller, voice),
                          icon: Icon(
                            Icons.delete,
                            color: AppColors.error,
                            size: 20.px,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, VoiceCloningController controller, dynamic voice) {
    Get.dialog(
      AlertDialog(
        title: AppText(
          'Delete Voice',
          fontSize: 18.px,
          fontWeight: FontWeight.bold,
        ),
        content: AppText(
          'Are you sure you want to delete "${voice.name}"? This action cannot be undone.',
          fontSize: 14.px,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: AppText(
              'Cancel',
              color: AppColors().darkAndWhite,
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.deleteClonedVoice(voice.voiceId);
            },
            child: AppText(
              'Delete',
              color: AppColors.error,
            ),
          ),
        ],
      ),
    );
  }
}
