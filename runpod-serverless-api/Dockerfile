FROM merrickfox/cuda-textgen:1.0.0 as base

RUN git config --global credential.helper store && \
    git lfs install


COPY scripts /root/scripts
RUN git clone https://huggingface.co/TheBloke/chronos-hermes-13B-GPTQ /root/text-generation-webui/models/chronos-hermes-13B-GPTQ

COPY --chmod=755 start-with-ui.sh /start.sh

WORKDIR /workspace


CMD [ "/start.sh" ]
