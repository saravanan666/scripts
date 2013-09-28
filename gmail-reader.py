import imaplib
import email
import getpass
import sys
count = 1
emailid=str(sys.argv[1])
p = getpass.getpass()

while True:
	for i in range(count, 1112):
		try:
			mail = imaplib.IMAP4_SSL('imap.gmail.com')
			r,d = mail.login(emailid,p)
			assert r == 'OK', 'login failed'
			mail.select("inbox")
			#mail.select("[Gmail]/Sent Mail")	
			typ, msg_data = mail.fetch(str(i), '(RFC822)')
			for response_part in msg_data:
				if isinstance(response_part, tuple):
					msg = email.message_from_string(response_part[1])
					for header in [ 'from', 'to', 'subject', 'date' ]:
						print '%-8s: %s' % (header.upper(), msg[header])
					print "-------------------------------------------------"
		except mail.abort, e:
			count = i	
			continue
	mail.logout()
	break
