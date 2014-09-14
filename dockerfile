FROM dockerfile/ubuntu

ENV HOME /testdropbox
RUN mkdir /testdropbox /dropbox && \
	cd dropbox && \
	$WGET -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

VOLUME ["/testdropbox"]
ADD bin /dropbox/bin
RUN cd /dropbox/bin && \
    $WGET "https://www.dropbox.com/download?dl=packages/dropbox.py" -O dropbox.py && \
    chmod a+x dropbox.py && \
    ln -s `pwd`/dropbox.py d

ENV PATH /dropbox/bin:$PATH
ENV DROPBOX_DIR $HOME/Dropbox

WORKDIR /data
CMD ["/image/bin/launch"]
