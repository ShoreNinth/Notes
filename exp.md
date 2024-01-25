# 论文

攻击者的目标：假设攻击者使用上述云服务生成水印图像。攻击者的目标是对水印图像进行后处理，以逃避基于水印的检测，同时保持图像的视觉质量。攻击者可能希望在不同场景中实现这些目标。例如，攻击者可能会利用生成的图像在互联网上散布虚假信息；攻击者可能会声称对人工智能生成的图像拥有所有权。从形式上看，攻击者的目的是通过添加微小的、人类无法感知的扰动，将水印图像 I 变成后处理图像 I，从而使检测器错误地将 Ipw 预测为非人工智能生成的图像。

Attacker’s goal: Suppose an attacker uses the aforementioned cloud service to generate a watermarked image I . The attacker aims to post-process the watermarked image to evade watermark-based detection while maintaining its visual quality. The attacker may desire to achieve such goals in various scenarios. For instance,the attacker may use the generated image to spread disinformation on the Internet; and the attacker may claim ownership of the AI-generated image. Formally, the attacker aims to turn the watermarked image I into a post-processed one I via adding a small, w pwhuman-imperceptible perturbation to it such that a detector falsely predicts Ipw as non-AI-generated. 

攻击者的背景知识： 回顾一下，水印方法有一个地面真实水印 w、一个编码器和一个解码器。基于水印的检测器需要 w、解码器和检测阈值 τ。由于检测不涉及编码器，因此攻击者是否可以使用编码器并不重要。不过，我们假设攻击者无法访问编码器。由于我们的攻击与编码器无关，因此适用于在生成图像时嵌入水印的水印方法 [9, 39, 42]。此外，我们假设攻击者无法访问 w。根据攻击者可以访问检测器的哪些信息（解码器和/或 τ），我们考虑了以下两种情况： 

Attacker’s background knowledge: Recall that a watermarking method has a ground-truth watermark w, an encoder, and a decoder. A watermark-based detector requires w, the decoder, and a detection threshold τ. Since detection does not involve the encoder, whether it is available to the attacker is not relevant. Nevertheless, we assume the attacker does not have access to the encoder. Since our attack is encoder-agnostic, it is applicable to watermarking methods [9, 39, 42] that embed watermarks to images at generation. Moreover, we assume the attacker does not have access to w. Depending on what information (decoder and/or τ) of the detectors the attacker has access to, we consider the following two scenarios: 

白盒。在这一威胁模型中，我们假设攻击者可以白箱访问检测器的解码器。这种情况会在不同情况下出现： 
1) 当服务提供商在解码器中公开解码器时，攻击者可以直接访问解码器。
1) 当服务提供商在公共检测中公开解码器时，攻击者可以直接访问解码器，例如，稳定扩散所使用的解码器就是公开的[27]； 
2）在终端用户检测中，当检测器作为终端用户应用程序部署时，攻击者可以对终端用户应用程序进行逆向工程，以获取解码器； 
3) 在第三方检测中，第三方可能会泄露解码器； 
以及 
4) 在 "检测即服务 "中，内部人员可能会泄露解码器，或攻击者可利用计算机系统漏洞实施数据泄露攻击。最近的一个第三方泄漏实例（但不是水印模型）是，Meta 公司与经过验证的第三方共享了其 LLaMA 模型，其中一个第三方将其泄漏给了公众[13]。

White-box. In this threat model, we assume the attacker has white-box access to the decoder of the detectors. This scenario arises in various circumstances: 
1) an attacker can directly access
the decoder when the service provider makes it public in public detection, e.g., the decoder used by Stable Diffusion is public [27]; 
2)an attacker can reverse engineer the end-user application to obtain the decoder when the detector is deployed as an end-user application in end-user detection; 
3) a third-party may leak the decoder in third-party detection; 
and 
4) an insider may leak the decoder or an attacker can exploit the computer system vulnerabilities to perform a data leakage attack in detection-as-a-service. A recent example of third-party leakage (not watermarking model, though) is that Meta shared its LLaMA model with verified third parties, one of which leaked it to the public [13].

例如，在公共检测（或第三方检测）中，不同的个人（或第三方）可以选择自己的 τ。因此，攻击者的目标不是用特定的 τ 来躲避特定的检测器，而是对水印图像进行后处理，以便在白盒设置中躲避任何检测阈值 τ > 0.5 的检测器。

Note that, given a decoder, different detectors may use different τ. For instance, in public detection (or third-party detection), different individuals (or third-parties) can choose their own τ. Therefore, instead of evading a particular detector with a specific τ, an attacker aims to post-process a watermarked image that can evade detectors with any detection threshold τ > 0.5 in the white-box setting. 
黑盒。在这一威胁模型中，我们假设攻击者可以黑箱访问带有解码器和 τ 的特定检测器（称为目标检测器），攻击者的目的是躲避这一目标检测器。具体来说，攻击者只能访问任何图像的二进制检测结果（"人工智能生成 "或 "非人工智能生成"）。这种威胁模型可能出现在检测即服务、终端用户检测或第三方检测中。例如，在检测即服务或终端用户检测中，攻击者可以查询目标检测器，以获取任何图像的检测结果。在第三方检测中，攻击者也可以从特定第三方获取任何图像的检测结果，例如，攻击者可以将图像上传到 Twitter，并根据图像是否被 Twitter 屏蔽获取检测结果。

Black-box. In this threat model, we assume the attacker has black-box access to a particular detector with a decoder and a τ (called target detector), and the attacker aims to evade this target detector. Specifically, the attacker only has access to the binary detection result ("AI-generated" or "non-AI-generated") for any image. This threat model may arise in detection-as-a-service, end- user detection, or third-party detection. For instance, in detection-as-a-service or end-user detection, the attacker can query the target detector to obtain the detection result for any image. In third-party detection, the attacker can also obtain the detection result for any image from a particular third party, e.g., the attacker can upload an image to Twitter and obtain the detection result depending on whether the image is blocked by Twitter or not.

攻击者的能力： 在白盒设置中，攻击者可以通过分析解码器对水印图像进行后处理。在黑盒环境中，攻击者可以查询目标检测器，获取任何图像的检测结果。此外，我们假设攻击者可以多次查询目标检测器。例如，攻击者可以轻松地向检测即服务或终端用户检测发送多个查询图像，并获取检测结果。我们承认，在第三方检测中，攻击者查询目标检测器可能需要更长的时间。例如，当第三方是 Twitter 时，攻击者将查询图像上传到 Twitter，可能需要等待一段时间才能获得检测结果，即 Twitter 阻止或不阻止查询图像。然而，正如我们的实验所显示的，攻击者只需要几十次查询，就能躲过目标检测器的检测，同时对水印图像添加少量扰动。

Attacker’s capability: In the white-box setting, an attacker can post-process a watermarked image via analyzing the decoder. In the black-box setting, the attacker can query the target detector to obtain the detection result for any image. Moreover, we assume the attacker can query the target detector multiple times. For instance, the attacker can easily send multiple query images to detection-as-a-service or end-user detection and obtain detection results. We acknowledge that it may take a longer time for the attacker to query a target detector in third-party detection. For instance, when the third-party is Twitter, the attacker uploads a query image to Twitter and may have to wait for some time before obtaining the detection result, i.e., Twitter blocks or does not block the query image. However, as our experiments will show, an attacker only needs dozens of queries to evade a target detector while adding a small perturbation to a watermarked image.