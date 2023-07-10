FROM merrickfox/cuda-textgen:1.0.0 as base

RUN git config --global credential.helper store && \
    git lfs install


COPY scripts /root/scripts
COPY guidance-broker /root/guidance-broker

COPY --chmod=755 start-with-ui.sh /start.sh

RUN git clone https://github.com/merrickfox/guidance_api /root/text-generation-webui/extensions/guidance_api && cd /root/text-generation-webui/extensions/guidance_api && pip3 install -r requirements.txt
RUN cd /root/guidance-broker && pip3 install -r requirements.txt


COPY ./scripts/settings-template.yaml /root/text-generation-webui/settings-template.yaml

WORKDIR /workspace


CMD [ "/start.sh" ]
