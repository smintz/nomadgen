import json
import click

from .client import NomadgenAPI
from .helpers import validate_json_output, jobToJSON

nomadgen_client = NomadgenAPI()


def abort_if_false(ctx, param, value):
    if not value:
        ctx.abort()


@click.group()
@click.option(
    "--addr", default="http://127.0.0.1:4646", help="Address of nomad server"
)
@click.option("--region", help="Run in region")
@click.option(
    "--skip-verify", is_flag=True, default=True, help="Skip TLS verification"
)
@click.option("--cacert", type=click.Path(), help="Path of CA file")
@click.option("--client-cert", type=click.Path())
@click.option("--client-key", type=click.Path())
def cli(addr, region, skip_verify, cacert, client_cert, client_key):
    nomadgen_client.addr = addr

    if region:
        nomadgen_client.set_region(region)

    if cacert:
        nomadgen_client.set_ca(cacert)
    else:
        nomadgen_client.set_ca(not skip_verify)

    nomadgen_client.set_tls_key(client_key)
    nomadgen_client.set_tls_cert(client_cert)
    pass


@click.command()
@click.option("-j", "--json", is_flag=True, help="Show as json")
def show(json):
    job = nomadgen_client.job
    if json:
        validate_json_output(jobToJSON(job))
    else:
        click.echo(job)


@click.command()
def diff():
    nomadgen_client.diff()


@click.command()
@click.option("-f", "--force", is_flag=True, help="Just run.")
@click.option(
    "-w", "--wait", is_flag=True, help="Wait for the deploy to complete."
)
@click.option(
    "-p",
    "--promote",
    is_flag=True,
    help="Automatically promote the job if all canaries are healthy",
)
def run(force, wait, promote):
    nomadgen_client.diff()
    if force:
        cont = True
    else:
        cont = click.confirm("Continue?")
    if cont:
        nomadgen_client.run()

    if wait:
        nomadgen_client.wait(promote=promote)


@click.command()
def eval():
    nomadgen_client.eval()


@click.command()
@click.confirmation_option(prompt="Are you sure you want to stop?")
def stop():
    nomadgen_client.stop()


@click.command()
@click.confirmation_option(prompt="Are you sure you want to restart?")
def restart():
    nomadgen_client.stop()
    nomadgen_client.run()


@click.command()
def tf():
    print(json.dumps({"output": jobToJSON(nomadgen_client.job)}))


cli.add_command(show)
cli.add_command(diff)
cli.add_command(run)
cli.add_command(stop)
cli.add_command(restart)
cli.add_command(eval)
cli.add_command(tf)


def export_if_last(job):
    nomadgen_client.set_job(job)
    cli(auto_envvar_prefix="NOMAD")
