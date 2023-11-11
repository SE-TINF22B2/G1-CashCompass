import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import * as nodemailer from 'nodemailer';

/**
 * This is the service regarding mail sending.
 */
@Injectable()
export class MailService {
  /**
   * The transporter from which mails will be send.
   *
   * @private
   * @type {nodemailer.Transporter}
   * @memberof MailService
   */
  private transporter: nodemailer.Transporter;

  /**
   * This creates a MailService and the transporter with the secrets.
   * @param {ConfigService} config - The service to access .env files.
   * 
   * @constructor
   */
  constructor(private readonly config: ConfigService) {
    this.transporter = nodemailer.createTransport({
      service: 'gmail',
      auth: {
        user: this.config.get('GMAIL_MAIL'),
        pass: this.config.get('GMAIL_PASSWORD'),
      },
    });
  }

  /**
   * This sends a tests mail to a given adress.
   * @param {string} adress - The mail adress to send the mail to
   * @returns {string} - The status of the mail
   */
  async sendTestMail(adress: string): Promise<string> {
    const mailOptions = {
      from: this.config.get('GMAIL_MAIL'),
      to: adress,
      subject: 'CashCompass',
      text: 'This is an Email from the cashcompass',
    };

    try {
      const info = await this.transporter.sendMail(mailOptions);
      console.log('Email sent: ' + info.response);
      return 'Mail sent successfully';
    } catch (error) {
      console.log(error);
      return error.message;
    }
  }
}
