FROM merrickfox/cuda-textgen:1.0.0 as base

RUN git config --global credential.helper store && \
    git lfs install


COPY scripts /root/scripts

COPY --chmod=755 start-with-ui.sh /start.sh

RUN /bin/sh -c git clone https://github.com/merrickfox/guidance_api /root/text-generation-webui/extensions && cd /root/text-generation-webui/extensions && pip3 install -r requirements.txt

COPY ./scripts/settings-template.yaml /root/text-generation-webui/settings-template.yaml

WORKDIR /workspace


CMD [ "/start.sh" ]
