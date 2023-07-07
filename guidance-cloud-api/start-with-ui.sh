#!/bin/bash
echo "Pod started"

SCRIPTDIR=/root/scripts
VOLUME=/workspace

if [[ ! -f /.built.llama-cpp-python ]]; then
	"$SCRIPTDIR"/build-llama-cpp-python.sh >>$VOLUME/logs/build-llama-cpp-python.log 2>&1 &
fi

if [[ $PUBLIC_KEY ]]; then
	mkdir -p ~/.ssh
	chmod 700 ~/.ssh
	cd ~/.ssh
	echo "$PUBLIC_KEY" >>authorized_keys
	chmod 700 -R ~/.ssh
	service ssh start
fi

"$SCRIPTDIR"/textgen-on-workspace.sh

if [[ $MODEL ]]; then
	"$SCRIPTDIR"/fetch-model.py "$MODEL" $VOLUME/text-generation-webui/models >>$VOLUME/logs/fetch-model.log 2>&1
fi

cd /workspace/text-generation-webui && git pull

cd /workspace/text-generation-webui/repositories/exllama && git pull

if [[ ! -f $VOLUME/run-text-generation-webui.sh ]]; then
	mv "$SCRIPTDIR"/run-text-generation-webui.sh $VOLUME/run-text-generation-webui.sh
fi

ARGS=()
while true; do
	if [[ ! -f $VOLUME/do.not.launch.UI ]]; then
		if [[ -f /tmp/text-gen-model ]]; then
			ARGS=(--model "$(</tmp/text-gen-model)")
		fi
		if [[ ${UI_ARGS} ]]; then
			ARGS=("${ARGS[@]}" ${UI_ARGS})
		fi

		($VOLUME/run-text-generation-webui.sh "${ARGS[@]}" 2>&1) >>$VOLUME/logs/text-generation-webui.log

	fi
	sleep 2
done

sleep infinity
